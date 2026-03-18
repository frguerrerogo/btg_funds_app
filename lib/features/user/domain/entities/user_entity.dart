import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Represents a user entity in the investment fund management system.
///
/// This entity encapsulates user information including identification,
/// personal data, account balance, and active fund subscriptions.
/// It provides utility methods to validate balance sufficiency,
/// check subscription status, and retrieve subscription details.
@freezed
abstract class UserEntity with _$UserEntity {
  /// Creates a new [UserEntity] instance.
  ///
  /// All parameters are required and define the user's core information:
  /// - [id]: The unique identifier for the user
  /// - [name]: The full name of the user
  /// - [balance]: The current account balance (in the system's currency/units)
  /// - [activeSubscriptions]: A list of active fund subscriptions for the user,
  ///   defaults to an empty list if not provided
  const factory UserEntity({
    required String id,
    required String name,
    required double balance,
    @Default([]) List<ActiveSubscriptionEntity> activeSubscriptions,
  }) = _UserEntity;

  const UserEntity._();

  /// Checks whether the user has sufficient balance to perform a transaction.
  ///
  /// Compares the user's current [balance] against the required [amount]
  /// to determine transaction eligibility. Returns `true` if the balance
  /// is sufficient to cover the [amount]; `false` otherwise.
  bool hasEnoughBalance(double amount) => balance >= amount;

  /// Checks whether the user is already subscribed to a specific fund.
  ///
  /// Verifies if a subscription with the provided [fundId] exists in the
  /// [activeSubscriptions] list. Returns `true` if the user is subscribed
  /// to the fund; `false` otherwise.
  bool isSubscribedToFund(String fundId) => activeSubscriptions.any((s) => s.fundId == fundId);

  /// Retrieves the active subscription details for a specific fund.
  ///
  /// Returns the [ActiveSubscriptionEntity] for the fund identified by [fundId]
  /// if the user is subscribed; returns `null` if the user has no active
  /// subscription for the specified fund.
  ActiveSubscriptionEntity? getSubscription(String fundId) =>
      activeSubscriptions.where((s) => s.fundId == fundId).firstOrNull;
}
