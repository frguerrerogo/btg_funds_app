import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper, UserDto, UserMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity;
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test: [UserMapper].
  late UserMapper mapper;

  /// Base ActiveSubscriptionDto fixture with fundId '1' and amount 75000.
  const tSubscriptionDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// Base UserDto fixture with id '1', balance 500000, and nested activeSubscriptions.
  const tUserDto = UserDto(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [tSubscriptionDto],
  );

  /// Base ActiveSubscriptionEntity fixture with fundId '1' and DateTime.parse('2024-01-01T00:00:00.000').
  final tSubscriptionEntity = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  /// Base UserEntity fixture with id '1', balance 500000, and nested activeSubscriptions.
  final tUserEntity = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [tSubscriptionEntity],
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
        // arrange
        const emptyUserDto = UserDto(
          id: '1',
          name: 'BTG User',
          balance: 500000,
          activeSubscriptions: [],
        );

        // act
        final result = mapper.modelToEntity(emptyUserDto);

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
        expect(result.balance, tUserEntity.balance);
        expect(result.activeSubscriptions.length, 1);
      });
    });
  });
}
