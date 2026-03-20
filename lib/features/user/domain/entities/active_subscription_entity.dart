import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_subscription_entity.freezed.dart';

/// Represents a user's active subscription to an investment fund.
/// Encapsulates the subscribed fund identity, invested amount, and the subscription timestamp.
@freezed
abstract class ActiveSubscriptionEntity with _$ActiveSubscriptionEntity {
  /// Creates an [ActiveSubscriptionEntity] describing an active fund subscription.
  /// [fundId] and [fundName] identify the fund, [amount] records the invested value, and [subscribedAt] records when it was subscribed.
  const factory ActiveSubscriptionEntity({
    required String fundId,
    required String fundName,
    required double amount,
    required DateTime subscribedAt,
  }) = _ActiveSubscriptionEntity;
}
