import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';
import 'package:btg_funds_app/features/user/domain/usecases/validate_balance_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [UserRepository] for testing purposes.
///
/// Provides a test double that simulates user data access without
/// hitting the actual data layer, enabling isolated unit tests.
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  /// System under test: the [ValidateBalanceUseCase] instance being tested.
  late ValidateBalanceUseCase sut;

  /// Mock repository dependency for the system under test.
  late MockUserRepository mockUserRepository;

  /// Base test user with COP $500,000 balance and no subscriptions.
  ///
  /// Used as the foundation for most test scenarios to represent a user
  /// with sufficient funds for typical fund subscription amounts.
  const tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
    subscribedFundIds: [],
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    sut = ValidateBalanceUseCase(mockUserRepository);
  });

  group('ValidateBalanceUseCase', () {
    group('when balance is sufficient', () {
      test('should return true for FPV_BTG_PACTUAL_RECAUDADORA (75.000)', () async {
        // arrange
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

        // act
        final result = await sut.execute(amount: 75000);

        // assert
        expect(result, true);
        verify(() => mockUserRepository.getUser()).called(1);
      });

      test('should return true when amount equals exact balance', () async {
        // arrange
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

        // act
        final result = await sut.execute(amount: 500000);

        // assert
        expect(result, true);
      });
    });

    group('when balance is insufficient', () {
      test('should return false when amount exceeds balance', () async {
        // arrange
        final userWithLowBalance = tUser.copyWith(balance: 50000);
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => userWithLowBalance);

        // act
        final result = await sut.execute(amount: 75000);

        // assert
        expect(result, false);
      });

      test('should return false when balance is zero', () async {
        // arrange
        final userWithNoBalance = tUser.copyWith(balance: 0);
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => userWithNoBalance);

        // act
        final result = await sut.execute(amount: 75000);

        // assert
        expect(result, false);
      });
    });
  });
}
