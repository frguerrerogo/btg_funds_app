import 'package:btg_funds_app/core/core.dart'
    show cancelFundUseCaseProvider, getFundsUseCaseProvider, subscribeFundUseCaseProvider;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show CancelFundUseCase, FundEntity, GetFundsUseCase, SubscribeFundUseCase;
import 'package:btg_funds_app/features/user/presentation/presentation.dart'
    show userControllerProvider;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'funds_controller.g.dart';

/// Controller that manages [List<FundEntity>] state for the funds feature.
@riverpod
class FundsController extends _$FundsController {
  late GetFundsUseCase _getFundsUseCase;
  late SubscribeFundUseCase _subscribeFundUseCase;
  late CancelFundUseCase _cancelFundUseCase;

  /// Initializes the controller and loads available funds on mount.
  @override
  Future<List<FundEntity>> build() async {
    _getFundsUseCase = ref.read(getFundsUseCaseProvider);
    _subscribeFundUseCase = ref.read(subscribeFundUseCaseProvider);
    _cancelFundUseCase = ref.read(cancelFundUseCaseProvider);
    return _getFundsUseCase.execute();
  }

  /// Subscribes the user to a fund with the given [fundId].
  /// Refreshes the user balance and updates the funds list.
  Future<void> subscribeFund({
    required String fundId,
    required String fundName,
    required double amount,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _subscribeFundUseCase.execute(fundId: fundId);
      await ref.read(userControllerProvider.notifier).refreshUser();
      return _getFundsUseCase.execute();
    });
  }

  /// Cancels the user's subscription to a fund with the given [fundId].
  /// Refreshes the user balance and updates the funds list.
  Future<void> cancelFund(String fundId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _cancelFundUseCase.execute(fundId: fundId);
      await ref.read(userControllerProvider.notifier).refreshUser();
      return _getFundsUseCase.execute();
    });
  }
}
