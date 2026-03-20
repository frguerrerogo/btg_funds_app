import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [ActiveSubscriptionMapper].
  late ActiveSubscriptionMapper mapper;

  /// Base [ActiveSubscriptionDto] fixture with amount 75000 and a DateTime string subscribedAt.
  const tDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// Base [ActiveSubscriptionEntity] fixture with amount 75000 and a DateTime subscribedAt.
  final tEntity = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  setUp(() {
    mapper = ActiveSubscriptionMapper();
  });

  group('ActiveSubscriptionMapper', () {
    group('modelToEntity', () {
      test('should map ActiveSubscriptionDto to ActiveSubscriptionEntity', () {
        final result = mapper.modelToEntity(tDto);
        expect(result, tEntity);
      });

      test('should map fundId correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.fundId, '1');
      });

      test('should map fundName correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.fundName, 'FPV_BTG_PACTUAL_RECAUDADORA');
      });

      test('should map amount correctly', () {
        final result = mapper.modelToEntity(tDto);
        expect(result.amount, 75000);
      });

      test('should parse subscribedAt string to DateTime', () {
        final result = mapper.modelToEntity(tDto);
        expect(
          result.subscribedAt,
          DateTime.parse('2024-01-01T00:00:00.000'),
        );
      });
    });

    group('entityToModel', () {
      test('should map ActiveSubscriptionEntity to ActiveSubscriptionDto', () {
        final result = mapper.entityToModel(tEntity);
        expect(result.fundId, tEntity.fundId);
        expect(result.fundName, tEntity.fundName);
        expect(result.amount, tEntity.amount);
        expect(result.subscribedAt, tEntity.subscribedAt.toIso8601String());
      });

      test('should map subscribedAt DateTime to ISO string', () {
        final result = mapper.entityToModel(tEntity);
        expect(result.subscribedAt, '2024-01-01T00:00:00.000');
      });
    });

    group('modelsToEntities', () {
      test('should map list of dtos to list of entities', () {
        final result = mapper.modelsToEntities([tDto, tDto]);
        expect(result.length, 2);
        expect(result.every((e) => e.fundId == '1'), true);
      });
    });

    group('entitiesToModels', () {
      test('should map list of entities to list of dtos', () {
        final result = mapper.entitiesToModels([tEntity, tEntity]);
        expect(result.length, 2);
        expect(result.every((d) => d.fundId == '1'), true);
      });
    });
  });
}
