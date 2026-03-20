import 'package:btg_funds_app/features/user/domain/entities/user_entity.dart';
import 'package:btg_funds_app/features/user/domain/repositories/user_repository.dart';
import 'package:btg_funds_app/features/user/domain/usecases/get_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [UserRepository] for testing purposes.
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  /// The system under test: [GetUserUseCase].
  late GetUserUseCase sut;

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

    test('should return user with no active subscriptions initially', () async {
      // arrange
      when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);

      // act
      final result = await sut.execute();

      // assert
      expect(result.activeSubscriptions, isEmpty);
    });
  });
}
