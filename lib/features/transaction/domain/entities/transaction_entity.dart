import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

/// Classifies a transaction by its operation type in the investment fund system.
enum TransactionType {
  /// Fund purchase or initial subscription initiated by the investor.
  subscription,

  /// Fund redemption or cancellation requested by the investor.
  cancellation,
}

/// Communication channel for delivering transaction notifications to investors.
enum NotificationMethod {
  /// Notification delivered via email to the investor's registered email address.
  email,

  /// Notification delivered via SMS to the investor's registered phone number.
  sms,
}

/// Represents a subscription or cancellation operation executed on an investment fund.
/// Encapsulates transaction details including fund, amount, operation type, and notification preference.
@freezed
abstract class TransactionEntity with _$TransactionEntity {
  /// Creates a transaction with [id], [fundId] and [fundName] identifying the operation, [amount] for the value, [type] for the operation classification, [notificationMethod] for delivery preference, and [createdAt] for the operation timestamp.
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

  /// Returns `true` if [type] is [TransactionType.subscription], `false` otherwise.
  bool get isSubscription => type == TransactionType.subscription;

  /// Returns `true` if [type] is [TransactionType.cancellation], `false` otherwise.
  bool get isCancellation => type == TransactionType.cancellation;
}
