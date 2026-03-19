import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/transaction/data/data.dart' show TransactionDto;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, TransactionEntity, TransactionType;

/// Mapper for converting between [TransactionEntity] and [TransactionDto].
///
/// Handles bidirectional conversion of transaction data:
/// - Domain entities to data transfer objects for persistence
/// - Data transfer objects to domain entities for business logic
/// Additionally manages type conversions for [TransactionType] and [NotificationMethod] enumerations.
class TransactionMapper extends Mapper<TransactionEntity, TransactionDto> {
  /// Converts a [TransactionDto] to a domain [TransactionEntity].
  ///
  /// Transforms the data transfer object [model] into a domain entity by mapping
  /// string representations of transaction type and notification method to their
  /// corresponding enum values, and converting the creation timestamp from ISO 8601 format.
  /// Returns a fully initialized [TransactionEntity] ready for business logic operations.
  @override
  TransactionEntity modelToEntity(TransactionDto model) {
    return TransactionEntity(
      id: model.id,
      fundId: model.fundId,
      fundName: model.fundName,
      amount: model.amount,
      type: _mapType(model.type),
      notificationMethod: _mapNotificationMethod(model.notificationMethod),
      createdAt: DateTime.parse(model.createdAt),
    );
  }

  /// Converts a [TransactionEntity] to a [TransactionDto].
  ///
  /// Transforms the domain entity [entity] into a data transfer object by mapping
  /// type and notification method enums to their string representations, and converting
  /// the creation timestamp to ISO 8601 format for storage.
  /// Returns a [TransactionDto] ready for persistence or API communication.
  @override
  TransactionDto entityToModel(TransactionEntity entity) {
    return TransactionDto(
      id: entity.id,
      fundId: entity.fundId,
      fundName: entity.fundName,
      amount: entity.amount,
      type: _mapTypeToString(entity.type),
      notificationMethod: _mapNotificationMethodToString(entity.notificationMethod),
      createdAt: entity.createdAt.toIso8601String(),
    );
  }

  TransactionType _mapType(String type) {
    switch (type) {
      case 'subscription':
        return TransactionType.subscription;
      case 'cancellation':
        return TransactionType.cancellation;
      default:
        throw ArgumentError('Unknown transaction type: $type');
    }
  }

  String _mapTypeToString(TransactionType type) {
    switch (type) {
      case TransactionType.subscription:
        return 'subscription';
      case TransactionType.cancellation:
        return 'cancellation';
    }
  }

  NotificationMethod _mapNotificationMethod(String method) {
    switch (method) {
      case 'email':
        return NotificationMethod.email;
      case 'sms':
        return NotificationMethod.sms;
      default:
        throw ArgumentError('Unknown notification method: $method');
    }
  }

  String _mapNotificationMethodToString(NotificationMethod method) {
    switch (method) {
      case NotificationMethod.email:
        return 'email';
      case NotificationMethod.sms:
        return 'sms';
    }
  }
}
