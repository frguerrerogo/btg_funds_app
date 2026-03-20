import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';
import 'package:btg_funds_app/features/user/domain/usecases/validate_balance_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [UserRepository] for testing purposes.
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  /// The system under test: [ValidateBalanceUseCase].
  late ValidateBalanceUseCase sut;

  /// Mock of [UserRepository] injected into [sut].
  late MockUserRepository mockUserRepository;

  /// Base UserEntity fixture with id '1' and balance 500000.
  const tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    sut = ValidateBalanceUseCase(mockUserRepository);
  });

  group('ValidateBalanceUseCase', () {
    group('when balance is sufficient', () {
      test('should return true for minimum amount of 75.000', () async {
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
