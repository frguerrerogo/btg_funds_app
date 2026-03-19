import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;
import 'package:json_annotation/json_annotation.dart';

part 'fund_dto.g.dart';

/// Data Transfer Object representing a fund resource from the API.
///
/// Used for JSON serialization/deserialization in the data layer.
/// Maps to [FundEntity] in the domain layer.
@JsonSerializable()
class FundDto {
  /// Creates a [FundDto] with the given fund attributes.
  const FundDto({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
    required this.isSubscribed,
  });

  /// Creates a [FundDto] from a JSON [Map].
  factory FundDto.fromJson(Map<String, dynamic> json) => _$FundDtoFromJson(json);

  /// The unique identifier of the fund.
  final String id;

  /// The display name of the fund.
  final String name;

  /// The minimum investment amount required for the fund. Mapped from JSON key `minimum_amount`.
  @JsonKey(name: 'minimum_amount')
  final double minimumAmount;

  /// The fund category type, represented as a string (e.g., 'FPV' or 'FIC').
  final String category;

  /// Whether the user is currently subscribed to this fund. Mapped from JSON key `is_subscribed`.
  @JsonKey(name: 'is_subscribed')
  final bool isSubscribed;

  /// Converts this [FundDto] to a JSON [Map].
  Map<String, dynamic> toJson() => _$FundDtoToJson(this);
}
