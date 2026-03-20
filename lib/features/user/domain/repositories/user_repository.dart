import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity;

/// Repository interface for accessing and managing user data.
///
/// Defines the domain contract for managing user profile and account information.
abstract class UserRepository {
  /// Retrieves the user.
  /// Returns a [UserEntity] reflecting the current user.
  Future<UserEntity> getUser();

  /// Updates the user account balance to [newBalance].
  /// Returns a [UserEntity] reflecting the updated balance.
  Future<UserEntity> updateBalance(double newBalance);

  /// Adds the active subscription provided in [subscription].
  /// Returns a [UserEntity] reflecting the updated subscriptions.
  Future<UserEntity> addActiveSubscription(ActiveSubscriptionEntity subscription);

  /// Unsubscribes the user from the fund identified by [fundId].
  /// Returns a [UserEntity] reflecting the updated subscriptions.
  Future<UserEntity> removeActiveSubscription(String fundId);
}
