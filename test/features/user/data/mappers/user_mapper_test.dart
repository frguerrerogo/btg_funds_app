// test/features/user/data/mappers/user_mapper_test.dart

import 'package:btg_funds_app/features/user/data/data.dart'
    show ActiveSubscriptionDto, ActiveSubscriptionMapper, UserDto, UserMapper;
import 'package:btg_funds_app/features/user/domain/domain.dart' show ActiveSubscriptionEntity;
import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// The system under test (SUT) - the user mapper being tested.
  /// Initialized with an ActiveSubscriptionMapper dependency.
  late UserMapper mapper;

  /// A test fixture representing a subscription DTO with standard data.
  /// Used as a nested component in user DTO tests.
  const tSubscriptionDto = ActiveSubscriptionDto(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: '2024-01-01T00:00:00.000',
  );

  /// A test fixture representing a user DTO with standard data.
  /// Includes a list of subscription DTOs and represents the API response format.
  /// Used to verify data-to-domain layer conversion.
  const tUserDto = UserDto(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    activeSubscriptions: [tSubscriptionDto],
  );

  /// A test fixture representing a subscription entity with standard data.
  /// Mirrors [tSubscriptionDto] but with DateTime parsing applied, used as a
  /// nested component in user entity tests.
  final tSubscriptionEntity = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  /// A test fixture representing a user entity with standard data.
  /// Mirrors [tUserDto] but with DateTime parsing applied for subscriptions.
  /// Represents the expected mapping output from DTO to domain entity.
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
