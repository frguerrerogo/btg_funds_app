import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test (SUT) - the mapper being tested.
  late ActiveSubscriptionMapper mapper;

  /// A test fixture representing a DTO with standard subscription data.
  /// Used to verify data-to-domain layer conversion.
  const tDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// A test fixture representing a domain entity with standard subscription data.
  /// Mirrors [tDto] but with DateTime parsing applied, used to verify
  /// the expected mapping output from DTO to entity.
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
        // act
        final result = mapper.modelToEntity(tDto);

        // assert
        expect(result, tEntity);
      });

      test('should parse subscribedAt string to DateTime', () {
        // act
        final result = mapper.modelToEntity(tDto);

        // assert
        expect(result.subscribedAt, DateTime.parse('2024-01-01T00:00:00.000'));
      });
    });

    group('entityToModel', () {
      test('should map ActiveSubscriptionEntity to ActiveSubscriptionDto', () {
        // act
        final result = mapper.entityToModel(tEntity);

        // assert
        expect(result.fundId, tEntity.fundId);
        expect(result.fundName, tEntity.fundName);
        expect(result.amount, tEntity.amount);
        expect(result.subscribedAt, tEntity.subscribedAt.toIso8601String());
      });
    });
  });
}
