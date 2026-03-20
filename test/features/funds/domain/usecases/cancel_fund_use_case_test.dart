import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show CancelFundUseCase, FundCategory, FundEntity, FundsRepository, NotSubscribedException;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity, UserRepository;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [FundsRepository] for testing purposes.
class MockFundsRepository extends Mock implements FundsRepository {}

/// Mock implementation of [UserRepository] for testing purposes.
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  /// The system under test: [CancelFundUseCase].
  late CancelFundUseCase sut;

  /// Mock of [FundsRepository] injected into [sut].
  late MockFundsRepository mockFundsRepository;

  /// Mock of [UserRepository] injected into [sut].
  late MockUserRepository mockUserRepository;

  /// Base [FundEntity] fixture with minimumAmount of 75000 and fpv category.
  const tFund = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
  );

  /// [ActiveSubscriptionEntity] fixture with fundId '1' and amount 75000.
  final tActiveSubscription = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  /// [UserEntity] fixture with balance 425000 and one active subscription.
  final tUserSubscribed = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 425000,
    activeSubscriptions: [tActiveSubscription],
  );

  /// Base [UserEntity] fixture with balance of 500000 and no active subscriptions.
  const tUserNotSubscribed = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
  );

  setUp(() {
    mockFundsRepository = MockFundsRepository();
    mockUserRepository = MockUserRepository();
    sut = CancelFundUseCase(
      fundsRepository: mockFundsRepository,
      userRepository: mockUserRepository,
    );
  });

  group('CancelFundUseCase', () {
    group('when user is subscribed', () {
      setUp(() {
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUserSubscribed);
        when(() => mockFundsRepository.getFundById('1')).thenAnswer((_) async => tFund);
        when(
          () => mockUserRepository.updateBalance(500000),
        ).thenAnswer((_) async => tUserSubscribed.copyWith(balance: 500000));
        when(
          () => mockUserRepository.removeActiveSubscription('1'),
        ).thenAnswer((_) async => tUserNotSubscribed);
      });

      test('should refund exact amount to user balance', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.updateBalance(500000)).called(1);
      });

      test('should remove active subscription from user', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.removeActiveSubscription('1')).called(1);
      });

      test('should return cancelled fund', () async {
        // act
        final result = await sut.execute(fundId: '1');

        // assert
        expect(result.id, '1');
        verify(() => mockFundsRepository.getFundById('1')).called(1);
      });
    });

    group('when user is not subscribed', () {
      test('should throw NotSubscribedException', () async {
        // arrange
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUserNotSubscribed);

        // act & assert
        expect(
          () => sut.execute(fundId: '1'),
          throwsA(isA<NotSubscribedException>()),
        );
      });
    });
  });
}
