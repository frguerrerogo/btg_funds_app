import 'package:btg_funds_app/core/core.dart'
    show
        cancelFundUseCaseProvider,
        getFundsUseCaseProvider,
        getUserUseCaseProvider,
        saveTransactionUseCaseProvider,
        subscribeFundUseCaseProvider;
import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        CancelFundUseCase,
        FundEntity,
        GetFundsUseCase,
        InsufficientBalanceException,
        NotSubscribedException,
        SubscribeFundUseCase;
import 'package:btg_funds_app/features/funds/presentation/presentation.dart' show FundsState;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, SaveTransactionUseCase, TransactionEntity, TransactionType;
import 'package:btg_funds_app/features/user/domain/domain.dart' show GetUserUseCase, UserEntity;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'funds_controller.g.dart';

/// Controller that manages [FundsState] state for the funds feature.
@riverpod
class FundsController extends _$FundsController {
  late GetFundsUseCase _getFundsUseCase;
  late GetUserUseCase _getUserUseCase;
  late SubscribeFundUseCase _subscribeFundUseCase;
  late CancelFundUseCase _cancelFundUseCase;
  late SaveTransactionUseCase _saveTransactionUseCase;
  final _logger = Logger();

  @override
  /// Initializes the controller and loads funds and user data on mount.
  Future<FundsState> build() async {
    _getFundsUseCase = ref.read(getFundsUseCaseProvider);
    _getUserUseCase = ref.read(getUserUseCaseProvider);
    _subscribeFundUseCase = ref.read(subscribeFundUseCaseProvider);
    _cancelFundUseCase = ref.read(cancelFundUseCaseProvider);
    _saveTransactionUseCase = ref.read(saveTransactionUseCaseProvider);

    try {
      return await _loadState();
    } catch (e) {
      _logger.e('Failed to load funds and user data: $e');
      rethrow;
    }
  }

  /// Loads funds and user in parallel — single network round trip
  Future<FundsState> _loadState() async {
    try {
      final results = await Future.wait([
        _getFundsUseCase.execute(),
        _getUserUseCase.execute(),
      ]);

      final funds = results[0] as List<FundEntity>;
      final user = results[1] as UserEntity;

      // Update isSubscribed status for each fund based on user's active subscriptions
      final fundsWithSubscriptionStatus = funds
          .map((fund) => fund.copyWith(isSubscribed: user.isSubscribedToFund(fund.id)))
          .toList();

      return FundsState(
        funds: fundsWithSubscriptionStatus,
        user: user,
      );
    } catch (e) {
      _logger.e('Error in _loadState: $e');
      rethrow;
    }
  }

  /// Subscribes the user to a fund with the specified [fundId], [name], and [minimumAmount].
  /// Saves the subscription transaction and updates the fund subscription status.
  /// On business logic errors, restores the previous state while notifying listeners.
  /// Returns true if subscription was successful, false otherwise.
  Future<bool> subscribeFund({
    required String fundId,
    required String name,
    required double minimumAmount,
    required NotificationMethod notificationMethod,
  }) async {
    if (!ref.mounted) return false;

    final currentState = await future;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updatedUser = await _subscribeFundUseCase.execute(
        user: currentState.user,
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

      final updatedFunds = currentState.funds.map((fund) {
        if (fund.id == fundId) {
          return fund.copyWith(isSubscribed: true);
        }
        return fund;
      }).toList();

      return currentState.copyWith(user: updatedUser, funds: updatedFunds);
    });

    if (state.hasError) {
      _handleFundOperationError(state.error, currentState);
      return false;
    }

    return true;
  }

  /// Cancels the user's subscription to the fund identified by [fundId].
  /// Saves the cancellation transaction and updates the fund subscription status.
  /// On business logic errors, restores the previous state while notifying listeners.
  /// Returns true if cancellation was successful, false otherwise.
  Future<bool> cancelFund({
    required String fundId,
    required String fundName,
    required double amount,
    required NotificationMethod notificationMethod,
  }) async {
    if (!ref.mounted) return false;

    final currentState = await future;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updatedUser = await _cancelFundUseCase.execute(user: currentState.user, fundId: fundId);

      await _saveTransactionUseCase.execute(
        TransactionEntity(
          id: const Uuid().v4(),
          fundId: fundId,
          fundName: fundName,
          amount: amount,
          type: TransactionType.cancellation,
          notificationMethod: notificationMethod,
          createdAt: DateTime.now(),
        ),
      );
      final updatedFunds = currentState.funds.map((fund) {
        if (fund.id == fundId) {
          return fund.copyWith(isSubscribed: false);
        }
        return fund;
      }).toList();

      return currentState.copyWith(user: updatedUser, funds: updatedFunds);
    });

    if (state.hasError) {
      _handleFundOperationError(state.error, currentState);
      return false;
    }

    return true;
  }

  /// Handles business logic exceptions by restoring the previous state to keep data visible.
  /// Known exceptions (InsufficientBalance, AlreadySubscribed, NotSubscribed) are handled
  /// silently, allowing listeners to notify users through the UI.
  void _handleFundOperationError(dynamic error, FundsState currentState) {
    if (error is InsufficientBalanceException ||
        error is AlreadySubscribedException ||
        error is NotSubscribedException) {
      state = AsyncData(currentState);
    }
  }
}
