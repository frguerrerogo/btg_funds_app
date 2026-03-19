import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;

/// Repository interface for accessing and managing user data.
/// Defines the domain contract for user profile and account information management.
abstract class UserRepository {
  /// Retrieves the current user with their account balance and active subscriptions. Returns a [UserEntity] containing the complete user profile.
  Future<UserEntity> getUser();

  /// Updates the user's account balance to the value specified by [newBalance]. Returns the [UserEntity] reflecting the updated balance.
  Future<UserEntity> updateBalance(double newBalance);

  /// Subscribes the user to the fund identified by [fundId]. Returns the [UserEntity] reflecting the updated subscriptions.
  Future<UserEntity> addSubscribedFund(String fundId);

  /// Unsubscribes the user from the fund identified by [fundId]. Returns the [UserEntity] reflecting the updated subscriptions.
  Future<UserEntity> removeSubscribedFund(String fundId);
}
