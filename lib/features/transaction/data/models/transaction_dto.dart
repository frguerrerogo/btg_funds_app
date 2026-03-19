import 'package:btg_funds_app/features/transaction/domain/domain.dart' show TransactionEntity;
import 'package:json_annotation/json_annotation.dart';

part 'transaction_dto.g.dart';

/// Data Transfer Object representing a transaction resource from the API.
///
/// Used for JSON serialization/deserialization in the data layer.
/// Maps to [TransactionEntity] in the domain layer.
@JsonSerializable()
class TransactionDto {
  /// Creates a [TransactionDto] with the given transaction attributes.
  const TransactionDto({
    required this.id,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.type,
    required this.notificationMethod,
    required this.createdAt,
  });

  /// Creates a [TransactionDto] from a JSON [Map].
  factory TransactionDto.fromJson(Map<String, dynamic> json) => _$TransactionDtoFromJson(json);

  /// The unique identifier for this transaction.
  final String id;

  /// The identifier of the investment fund affected by this transaction. Mapped from JSON key `fund_id`.
  @JsonKey(name: 'fund_id')
  final String fundId;

  /// The display name of the investment fund. Mapped from JSON key `fund_name`.
  @JsonKey(name: 'fund_name')
  final String fundName;

  /// The monetary amount of this transaction in the fund's base currency.
  final double amount;

  /// The type of transaction operation as a string ('subscription' or 'cancellation').
  final String type;

  /// The communication method for transaction confirmations and notifications. Mapped from JSON key `notification_method`.
  @JsonKey(name: 'notification_method')
  final String notificationMethod;

  /// The timestamp when this transaction was originally created, in ISO 8601 format. Mapped from JSON key `created_at`.
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// Converts this [TransactionDto] to a JSON [Map].
  Map<String, dynamic> toJson() => _$TransactionDtoToJson(this);
}
