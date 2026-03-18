import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;

/// Domain repository interface for user data access and management.
///
/// Defines the contract for accessing and modifying user information,
/// including account balance and fund subscriptions. This is an abstraction
/// layer that decouples business logic from data source implementation details.
abstract class UserRepository {
  /// Retrieves the current user with their account balance and subscribed funds.
  ///
  /// Returns a [UserEntity] containing the user's complete profile.
  Future<UserEntity> getUser();

  /// Updates the user's account balance following a subscription or cancellation.
  ///
  /// Modifies the account balance to [newBalance] and returns a [UserEntity]
  /// reflecting the updated state.
  ///
  /// Throws [Exception] if the update operation fails.
  Future<UserEntity> updateBalance(double newBalance);

  /// Subscribes the user to a fund by adding it to the subscribed funds list.
  ///
  /// Adds the fund identified by [fundId] to the user's portfolio and returns
  /// a [UserEntity] with the updated subscriptions.
  ///
  /// Throws [Exception] if the subscription operation fails.
  Future<UserEntity> addSubscribedFund(String fundId);

  /// Unsubscribes the user from a fund by removing it from the subscribed funds list.
  ///
  /// Removes the fund identified by [fundId] from the user's portfolio and returns
  /// a [UserEntity] with the updated subscriptions.
  ///
  /// Throws [Exception] if the unsubscription operation fails.
  Future<UserEntity> removeSubscribedFund(String fundId);
}
