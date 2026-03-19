import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [ActiveSubscriptionMapper].
  late ActiveSubscriptionMapper mapper;

  /// Base ActiveSubscriptionDto fixture with fundId '1' and subscribedAt '2024-01-01T00:00:00.000'.
  const tDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// Base ActiveSubscriptionEntity fixture with fundId '1' and DateTime.parse('2024-01-01T00:00:00.000').
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
