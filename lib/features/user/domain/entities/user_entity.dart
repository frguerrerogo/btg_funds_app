import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Represents a user entity with balance and fund subscriptions.
///
/// This entity encapsulates user information including identification,
/// personal data, account balance, and subscribed investment funds.
/// It provides utility methods to validate balance and subscription status.
@freezed
abstract class UserEntity with _$UserEntity {
  /// Creates a new [UserEntity] instance.
  ///
  /// All parameters are required and define the user's core information:
  /// - [id]: The unique identifier for the user
  /// - [name]: The full name of the user
  /// - [balance]: The current account balance (in the system's currency/units)
  /// - [subscribedFundIds]: A list of fund identifiers to which the user is subscribed
  const factory UserEntity({
    required String id,
    required String name,
    required double balance,
    required List<String> subscribedFundIds,
  }) = _UserEntity;

  const UserEntity._();

  /// Checks whether the user has sufficient balance to subscribe to a fund.
  ///
  /// Compares the user's current [balance] against the required [amount]
  /// to determine subscription eligibility. Returns `true` if the balance
  /// is sufficient to cover the [amount]; `false` otherwise.
  bool hasEnoughBalance(double amount) => balance >= amount;

  /// Checks whether the user is already subscribed to a specific fund.
  ///
  /// Verifies if [fundId] exists in the [subscribedFundIds] list.
  /// Returns `true` if the user is subscribed to the fund; `false` otherwise.
  bool isSubscribedToFund(String fundId) => subscribedFundIds.contains(fundId);
}
