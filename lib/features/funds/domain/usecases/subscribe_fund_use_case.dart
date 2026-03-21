import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show AlreadySubscribedException, InsufficientBalanceException;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity, UserRepository;
import 'package:btg_funds_app/features/user/domain/entities/active_subscription_entity.dart'
    show ActiveSubscriptionEntity;

/// Use case that subscribes a user to a fund.
///
/// Depends on [UserRepository] for user account updates.
class SubscribeFundUseCase {
  /// Creates a [SubscribeFundUseCase] with [userRepository].
  const SubscribeFundUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  /// Subscribes the user to the fund identified by [fundId] with [name] and [minimumAmount].
  /// Returns a [UserEntity] with the updated subscription and balance.
  /// Throws [AlreadySubscribedException] if the user is already subscribed, or [InsufficientBalanceException] if the user has insufficient balance.
  Future<UserEntity> execute({
    required UserEntity user,
    required String fundId,
    required String name,
    required double minimumAmount,
  }) async {
    // Validation based on user activeSubscriptions
    if (user.isSubscribedToFund(fundId)) {
      throw const AlreadySubscribedException();
    }

    if (!user.hasEnoughBalance(minimumAmount)) {
      throw const InsufficientBalanceException();
    }

    final newBalance = user.balance - minimumAmount;
    await _userRepository.updateBalance(newBalance);
    final updatedUser = await _userRepository.addActiveSubscription(
      ActiveSubscriptionEntity(
        fundId: fundId,
        fundName: name,
        amount: minimumAmount,
        subscribedAt: DateTime.now(),
      ),
    );

    return updatedUser;
  }
}
