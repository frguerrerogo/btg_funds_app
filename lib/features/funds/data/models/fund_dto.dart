import 'package:btg_funds_app/features/funds/domain/domain.dart' show FundEntity;
import 'package:json_annotation/json_annotation.dart';

part 'fund_dto.g.dart';

/// Data Transfer Object representing a fund resource from the API.
///
/// [FundDto] is used for serializing and deserializing fund data from JSON responses,
/// mapping API data to the domain layer's [FundEntity].
@JsonSerializable()
class FundDto {
  /// Creates a new [FundDto] instance.
  ///
  /// Requires all fund attributes including [id], [name], [minimumAmount],
  /// [category], and [isSubscribed] status.
  const FundDto({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
    required this.isSubscribed,
  });

  /// Constructs a [FundDto] instance from a JSON map.
  ///
  /// Deserializes JSON data received from the API into a [FundDto] object,
  /// handling field name transformations defined by [JsonKey] annotations.
  factory FundDto.fromJson(Map<String, dynamic> json) => _$FundDtoFromJson(json);

  /// The unique identifier of the fund.
  final String id;

  /// The display name of the fund.
  final String name;

  /// The minimum investment amount required for the fund.
  /// Corresponds to the 'minimum_amount' field in the JSON response.
  @JsonKey(name: 'minimum_amount')
  final double minimumAmount;

  /// The fund category type, represented as a string (e.g., 'FPV' or 'FIC').
  final String category;

  /// Whether the user is currently subscribed to this fund.
  /// Corresponds to the 'is_subscribed' field in the JSON response.
  @JsonKey(name: 'is_subscribed')
  final bool isSubscribed;

  /// Converts this [FundDto] instance to a JSON map.
  ///
  /// Serializes the DTO into a JSON-compatible map for API requests or persistence,
  /// handling field name transformations defined by [JsonKey] annotations.
  Map<String, dynamic> toJson() => _$FundDtoToJson(this);
}
