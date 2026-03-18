import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_subscription_entity.freezed.dart';

/// Represents an active subscription to an investment fund.
///
/// This entity encapsulates the details of a user's active investment
/// in a specific fund, including fund identification, investment amount,
/// and subscription timestamp. It tracks the user's portfolio holdings
/// and provides key information for managing fund subscriptions.
@freezed
abstract class ActiveSubscriptionEntity with _$ActiveSubscriptionEntity {
  /// Creates a new [ActiveSubscriptionEntity] instance.
  ///
  /// All parameters are required and define the subscription's core information:
  /// - [fundId]: The unique identifier of the fund being subscribed to
  /// - [fundName]: The display name of the investment fund
  /// - [amount]: The monetary value invested in the fund
  /// - [subscribedAt]: The date and time when the subscription was created
  const factory ActiveSubscriptionEntity({
    required String fundId,
    required String fundName,
    required double amount,
    required DateTime subscribedAt,
  }) = _ActiveSubscriptionEntity;
}
