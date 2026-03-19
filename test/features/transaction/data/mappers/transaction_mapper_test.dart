import 'package:btg_funds_app/features/transaction/data/data.dart'
    show TransactionDto, TransactionMapper;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show NotificationMethod, TransactionEntity, TransactionType;
import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [TransactionMapper].
  late TransactionMapper mapper;

  /// Base [TransactionDto] fixture for subscription transactions with email notification.
  const tDto = TransactionDto(
    id: '1',
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    type: 'subscription',
    notificationMethod: 'email',
    createdAt: '2024-01-01T00:00:00.000',
  );

  /// Base [TransactionDto] fixture for cancellation transactions with email notification.
  const tCancellationDto = TransactionDto(
    id: '1',
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    type: 'cancellation',
    notificationMethod: 'email',
    createdAt: '2024-01-01T00:00:00.000',
  );

  /// Base [TransactionDto] fixture for subscription transactions with SMS notification.
  const tSmsDto = TransactionDto(
    id: '1',
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    type: 'subscription',
    notificationMethod: 'sms',
    createdAt: '2024-01-01T00:00:00.000',
  );

  /// Base [TransactionEntity] fixture for subscription transactions with email notification.
  final tEntity = TransactionEntity(
    id: '1',
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    type: TransactionType.subscription,
    notificationMethod: NotificationMethod.email,
    createdAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  setUp(() {
    mapper = TransactionMapper();
  });

  group('TransactionMapper', () {
    group('modelToEntity', () {
      test('should map TransactionDto to TransactionEntity correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result, tEntity);
      });

      test('should map subscription type correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.type, TransactionType.subscription);
      });

      test('should map cancellation type correctly', () {
        final result = mapper.modelToEntity(tCancellationDto);
        expect(result.type, TransactionType.cancellation);
      });

      test('should map email notification method correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.notificationMethod, NotificationMethod.email);
      });

      test('should map sms notification method correctly', () {
        final result = mapper.modelToEntity(tSmsDto);
        expect(result.notificationMethod, NotificationMethod.sms);
      });

      test('should parse createdAt string to DateTime', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.createdAt, DateTime.parse('2024-01-01T00:00:00.000'));
      });
    });

    group('entityToModel', () {
      test('should map TransactionEntity to TransactionDto correctly', () {
        final result = mapper.entityToModel(tEntity);
        expect(result.id, tEntity.id);
        expect(result.type, 'subscription');
        expect(result.notificationMethod, 'email');
        expect(result.createdAt, tEntity.createdAt.toIso8601String());
      });
    });
  });
}
