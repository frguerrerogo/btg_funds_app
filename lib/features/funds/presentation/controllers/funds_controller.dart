import 'package:btg_funds_app/core/core.dart'
    show
        cancelFundUseCaseProvider,
        getFundsUseCaseProvider,
        saveTransactionUseCaseProvider,
        subscribeFundUseCaseProvider;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show CancelFundUseCase, FundEntity, GetFundsUseCase, SubscribeFundUseCase;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, SaveTransactionUseCase, TransactionEntity, TransactionType;
import 'package:btg_funds_app/features/user/presentation/presentation.dart'
    show userControllerProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'funds_controller.g.dart';

/// Controller that manages fund list state for the funds feature.
@riverpod
class FundsController extends _$FundsController {
  late GetFundsUseCase _getFundsUseCase;
  late SubscribeFundUseCase _subscribeFundUseCase;
  late CancelFundUseCase _cancelFundUseCase;
  late SaveTransactionUseCase _saveTransactionUseCase;

  /// Initializes the controller and loads funds on mount.
  @override
  Future<List<FundEntity>> build() async {
    _getFundsUseCase = ref.read(getFundsUseCaseProvider);
    _subscribeFundUseCase = ref.read(subscribeFundUseCaseProvider);
    _cancelFundUseCase = ref.read(cancelFundUseCaseProvider);
    _saveTransactionUseCase = ref.read(saveTransactionUseCaseProvider);
    return _getFundsUseCase.execute();
  }

  /// Subscribes the user to the fund identified by [fundId] with [name] and [minimumAmount].
  /// Refreshes the user state after successful subscription.
  Future<void> subscribeFund({
    required String fundId,
    required String name,
    required double minimumAmount,
    required NotificationMethod notificationMethod,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _subscribeFundUseCase.execute(
        fundId: fundId,
        name: name,
        minimumAmount: minimumAmount,
      );

      await _saveTransactionUseCase.execute(
        TransactionEntity(
          id: const Uuid().v4(),
          fundId: fundId,
          fundName: name,
          amount: minimumAmount,
          type: TransactionType.subscription,
          notificationMethod: notificationMethod,
          createdAt: DateTime.now(),
        ),
      );

      await ref.read(userControllerProvider.notifier).refreshUser();
      return _getFundsUseCase.execute();
    });
  }

  /// Cancels the fund subscription identified by [fundId].
  /// Refreshes the user state after successful cancellation.
  Future<void> cancelFund({required String fundId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _cancelFundUseCase.execute(fundId: fundId);
      await ref.read(userControllerProvider.notifier).refreshUser();
      return _getFundsUseCase.execute();
    });
  }
}
