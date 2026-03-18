import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';
import 'package:btg_funds_app/features/user/domain/usecases/get_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [UserRepository] for testing purposes.
///
/// Provides a test double that simulates user data access without
/// hitting the actual data layer, enabling isolated unit tests.
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  /// System under test: the [GetUserUseCase] instance being tested.
  late GetUserUseCase sut;

  /// Mock repository dependency for the system under test.
  late MockUserRepository mockUserRepository;

  /// Base test user with COP $500,000 balance and no subscriptions.
  ///
  /// Represents a standard user profile used across test scenarios,
  /// providing consistent test data for verifying user retrieval logic.
  const tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    subscribedFundIds: [],
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    sut = GetUserUseCase(mockUserRepository);
  });

  group('GetUserUseCase', () {
    test('should return user from repository', () async {
      // arrange
      when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

      // act
      final result = await sut.execute();

      // assert
      expect(result, tUser);
      verify(() => mockUserRepository.getUser()).called(1);
    });

    test('should return user with initial balance of 500.000', () async {
      // arrange
      when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

      // act
      final result = await sut.execute();

      // assert
      expect(result.balance, 500000);
    });

    test('should return user with no subscribed funds initially', () async {
      // arrange
      when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

      // act
      final result = await sut.execute();

      // assert
      expect(result.subscribedFundIds, isEmpty);
    });
  });
}
