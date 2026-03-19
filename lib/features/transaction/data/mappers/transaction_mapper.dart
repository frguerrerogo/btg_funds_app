import 'package:btg_funds_app/core/core.dart' show Mapper;
import 'package:btg_funds_app/features/transaction/data/data.dart' show TransactionDto;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, TransactionEntity, TransactionType;

/// Mapper that converts between [TransactionEntity] and [TransactionDto].
class TransactionMapper extends Mapper<TransactionEntity, TransactionDto> {
  /// Converts a [TransactionDto] from data into a [TransactionEntity].
  /// Returns a [TransactionEntity] populated with data from [model].
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

  /// Converts a [TransactionEntity] from domain into a [TransactionDto].
  /// Returns a [TransactionDto] populated with data from [entity].
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
