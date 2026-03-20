import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper, UserDto, UserMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity;
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [UserMapper].
  late UserMapper mapper;

  /// Base [ActiveSubscriptionDto] fixture with amount 75000.
  const tSubscriptionDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// Base [ActiveSubscriptionEntity] fixture with amount 75000.
  final tSubscriptionEntity = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  /// Base [UserDto] fixture with balance 500000 and one active subscription.
  const tUserDto = UserDto(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [tSubscriptionDto],
  );

  /// Base [UserEntity] fixture with balance 500000 and one active subscription.
  final tUserEntity = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [tSubscriptionEntity],
  );

  /// [UserDto] fixture with balance 500000 and empty active subscriptions list.
  const tEmptyUserDto = UserDto(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [],
  );

  setUp(() {
    mapper = UserMapper(
      activeSubscriptionMapper: ActiveSubscriptionMapper(),
    );
  });

  group('UserMapper', () {
    group('modelToEntity', () {
      test('should map UserDto to UserEntity correctly', () {
        // act
        final result = mapper.modelToEntity(tUserDto);

        // assert
        expect(result, tUserEntity);
      });

      test('should map id correctly', () {
        final result = mapper.modelToEntity(tUserDto);
        expect(result.id, '1');
      });

      test('should map balance correctly', () {
        final result = mapper.modelToEntity(tUserDto);
        expect(result.balance, 500000);
      });

      test('should map active subscriptions correctly', () {
        // act
        final result = mapper.modelToEntity(tUserDto);

        // assert
        expect(result.activeSubscriptions.length, 1);
        expect(result.activeSubscriptions.first.fundId, '1');
        expect(result.activeSubscriptions.first.amount, 75000);
      });

      test('should map subscribedAt string to DateTime', () {
        // act
        final result = mapper.modelToEntity(tUserDto);

        // assert
        expect(
          result.activeSubscriptions.first.subscribedAt,
          DateTime.parse('2024-01-01T00:00:00.000'),
        );
      });

      test('should return empty subscriptions when list is empty', () {
        // act
        final result = mapper.modelToEntity(tEmptyUserDto);

        // assert
        expect(result.activeSubscriptions, isEmpty);
      });
    });

    group('entityToModel', () {
      test('should map UserEntity to UserDto correctly', () {
        // act
        final result = mapper.entityToModel(tUserEntity);

        // assert
        expect(result.id, tUserEntity.id);
        expect(result.name, tUserEntity.name);
        expect(result.balance, tUserEntity.balance);
      });

      test('should map active subscriptions to dtos', () {
        // act
        final result = mapper.entityToModel(tUserEntity);

        // assert
        expect(result.activeSubscriptions.length, 1);
        expect(result.activeSubscriptions.first.fundId, '1');
        expect(result.activeSubscriptions.first.amount, 75000);
      });

      test('should map subscribedAt DateTime to string', () {
        // act
        final result = mapper.entityToModel(tUserEntity);

        // assert
        expect(
          result.activeSubscriptions.first.subscribedAt,
          '2024-01-01T00:00:00.000',
        );
      });
    });

    group('modelsToEntities', () {
      test('should map list of dtos to list of entities', () {
        // act
        final result = mapper.modelsToEntities([tUserDto, tEmptyUserDto]);

        // assert
        expect(result.length, 2);
        expect(result.first.activeSubscriptions.length, 1);
        expect(result.last.activeSubscriptions, isEmpty);
      });
    });
  });
}
