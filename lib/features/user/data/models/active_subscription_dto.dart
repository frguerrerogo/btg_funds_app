import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:json_annotation/json_annotation.dart';

part 'active_subscription_dto.g.dart';

/// Data Transfer Object representing an active subscription resource from the API.
///
/// Used for JSON serialization/deserialization in the data layer.
/// Maps to [ActiveSubscriptionEntity] in the domain layer.
@JsonSerializable()
class ActiveSubscriptionDto {
  /// Creates an [ActiveSubscriptionDto] with the given active subscription attributes.
  const ActiveSubscriptionDto({
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.subscribedAt,
  });

  /// Creates an [ActiveSubscriptionDto] from a JSON [Map].
  factory ActiveSubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveSubscriptionDtoFromJson(json);

  /// The unique identifier of the investment fund. Mapped from JSON key `fund_id`.
  @JsonKey(name: 'fund_id')
  final String fundId;

  /// The display name of the investment fund. Mapped from JSON key `fund_name`.
  @JsonKey(name: 'fund_name')
  final String fundName;

  /// The monetary value invested in the fund.
  final double amount;

  /// The date and time when the subscription was created. Mapped from JSON key `subscribed_at`.
  @JsonKey(name: 'subscribed_at')
  final String subscribedAt;

  /// Converts this [ActiveSubscriptionDto] to a JSON [Map].
  Map<String, dynamic> toJson() => _$ActiveSubscriptionDtoToJson(this);
}
