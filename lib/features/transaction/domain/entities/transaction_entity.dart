import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

/// Represents the classification of a financial transaction in the investment fund system.
///
/// Used to distinguish between different types of operations that investors can perform
/// on their fund positions.
enum TransactionType {
  /// Indicates the investor is initiating a subscription or purchase of fund shares.
  subscription,

  /// Indicates the investor is cancelling or redeeming their fund shares.
  cancellation,
}

/// Defines the communication channels through which transaction notifications are sent to investors.
///
/// Used to determine the preferred method for delivering transaction confirmations
/// and important fund-related information.
enum NotificationMethod {
  /// Notification will be delivered via email to the investor's registered email address.
  email,

  /// Notification will be delivered via SMS to the investor's registered phone number.
  sms,
}

/// Represents a financial transaction executed on an investment fund.
///
/// Encapsulates all relevant information about a subscription or cancellation operation,
/// including the fund details, transaction amount, type of operation, and how the investor
/// should be notified. Domain entity used to model investment fund transactions in the
/// application's business logic layer.
@freezed
abstract class TransactionEntity with _$TransactionEntity {
  /// Creates a new transaction record with the specified details.
  ///
  /// The [id] serves as the unique identifier for this transaction within the system.
  /// The [fundId] and [fundName] identify the specific investment fund affected by this transaction.
  /// The [amount] represents the monetary value of this transaction in the fund's base currency.
  /// The [type] classifies the transaction as either a subscription or cancellation operation.
  /// The [notificationMethod] determines whether confirmation will be sent via [NotificationMethod.email] or [NotificationMethod.sms].
  /// The [createdAt] timestamp records when this transaction was originally recorded.
  const factory TransactionEntity({
    required String id,
    required String fundId,
    required String fundName,
    required double amount,
    required TransactionType type,
    required NotificationMethod notificationMethod,
    required DateTime createdAt,
  }) = _TransactionEntity;

  const TransactionEntity._();

  /// Returns true if this transaction represents a fund subscription, false otherwise.
  bool get isSubscription => type == TransactionType.subscription;

  /// Returns true if this transaction represents a fund cancellation, false otherwise.
  bool get isCancellation => type == TransactionType.cancellation;
}
