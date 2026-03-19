import 'package:btg_funds_app/features/transaction/domain/domain.dart' show TransactionEntity;
import 'package:json_annotation/json_annotation.dart';

part 'transaction_dto.g.dart';

/// Represents the data transfer object for a financial transaction.
///
/// This DTO encapsulates transaction data as received from the API or persistence layer,
/// handling JSON serialization and deserialization. It maps to [TransactionEntity]
/// in the domain layer after appropriate transformation and validation.
@JsonSerializable()
class TransactionDto {
  /// Creates a new transaction DTO with the specified details.
  ///
  /// The [id] uniquely identifies this transaction within the system.
  /// The [fundId] identifies the investment fund affected (mapped from 'fund_id' in JSON).
  /// The [fundName] provides the display name of the fund (mapped from 'fund_name' in JSON).
  /// The [amount] represents the monetary value in the fund's base currency.
  /// The [type] indicates the operation type as a string value ('subscription' or 'cancellation').
  /// The [notificationMethod] specifies the communication channel (mapped from 'notification_method' in JSON).
  /// The [createdAt] records the creation timestamp in ISO 8601 format (mapped from 'created_at' in JSON).
  const TransactionDto({
    required this.id,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.type,
    required this.notificationMethod,
    required this.createdAt,
  });

  /// Constructs a [TransactionDto] instance from a JSON object.
  ///
  /// Deserializes the provided [json] map into a fully initialized [TransactionDto],
  /// automatically mapping snake_case JSON keys to their corresponding properties.
  factory TransactionDto.fromJson(Map<String, dynamic> json) => _$TransactionDtoFromJson(json);

  /// The unique identifier for this transaction.
  final String id;

  /// The identifier of the investment fund affected by this transaction.
  /// Mapped from the JSON key 'fund_id'.
  @JsonKey(name: 'fund_id')
  final String fundId;

  /// The display name of the investment fund.
  /// Mapped from the JSON key 'fund_name'.
  @JsonKey(name: 'fund_name')
  final String fundName;

  /// The monetary amount of this transaction in the fund's base currency.
  final double amount;

  /// The type of transaction operation as a string ('subscription' or 'cancellation').
  final String type;

  /// The communication method for transaction confirmations and notifications.
  /// Mapped from the JSON key 'notification_method'.
  @JsonKey(name: 'notification_method')
  final String notificationMethod;

  /// The timestamp when this transaction was originally created, in ISO 8601 format.
  /// Mapped from the JSON key 'created_at'.
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// Converts this [TransactionDto] instance to a JSON-serializable map.
  ///
  /// The generated map uses snake_case keys matching the API or persistence layer format.
  Map<String, dynamic> toJson() => _$TransactionDtoToJson(this);
}
