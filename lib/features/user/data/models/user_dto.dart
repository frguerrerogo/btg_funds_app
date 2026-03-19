import 'package:btg_funds_app/features/user/data/data.dart' show ActiveSubscriptionDto;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity;
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

/// Data Transfer Object representing a user resource from the API.
///
/// Used for JSON serialization/deserialization in the data layer.
/// Maps to [UserEntity] in the domain layer.
@JsonSerializable()
class UserDto {
  /// Creates a [UserDto] with the given user attributes.
  const UserDto({
    required this.id,
    required this.name,
    required this.balance,
    required this.activeSubscriptions,
  });

  /// Creates a [UserDto] from a JSON [Map].
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  /// The unique identifier of the user.
  final String id;

  /// The full name of the user.
  final String name;

  /// The current account balance of the user.
  final double balance;

  /// A list of active fund subscriptions for the user. Mapped from JSON key `active_subscriptions`.
  @JsonKey(name: 'active_subscriptions')
  final List<ActiveSubscriptionDto> activeSubscriptions;

  /// Converts this [UserDto] to a JSON [Map].
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
