import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        FundCategory,
        FundEntity,
        FundsRepository,
        InsufficientBalanceException,
        SubscribeFundUseCase;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity, UserRepository;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [FundsRepository] for testing purposes.
class MockFundsRepository extends Mock implements FundsRepository {}

/// Mock implementation of [UserRepository] for testing purposes.
class MockUserRepository extends Mock implements UserRepository {}

/// Fake implementation of [ActiveSubscriptionEntity] for mocktail registration.
class FakeActiveSubscriptionEntity extends Fake implements ActiveSubscriptionEntity {}

void main() {
  /// The system under test: [SubscribeFundUseCase].
  late SubscribeFundUseCase sut;

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

  /// Base [UserEntity] fixture with balance of 500000 and no active subscriptions.
  const tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
  );

  /// [UserEntity] fixture with existing subscription to fund '1' and reduced balance of 425000.
  final tUserAlreadySubscribed = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 425000,
    activeSubscriptions: [
      ActiveSubscriptionEntity(
        fundId: '1',
        fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
        amount: 75000,
        subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(FakeActiveSubscriptionEntity());
  });

  setUp(() {
    mockFundsRepository = MockFundsRepository();
    mockUserRepository = MockUserRepository();
    sut = SubscribeFundUseCase(
      fundsRepository: mockFundsRepository,
      userRepository: mockUserRepository,
    );
  });

  group('SubscribeFundUseCase', () {
    group('when balance is sufficient', () {
      setUp(() {
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);
        when(() => mockFundsRepository.getFundById('1')).thenAnswer((_) async => tFund);
        when(
          () => mockUserRepository.updateBalance(425000),
        ).thenAnswer((_) async => tUser.copyWith(balance: 425000));
        when(() => mockUserRepository.addActiveSubscription(any())).thenAnswer((_) async => tUser);
      });

      test('should update user balance after subscription', () async {
        // act
        await sut.execute(
          fundId: '1',
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        verify(() => mockUserRepository.updateBalance(425000)).called(1);
      });

      test('should add active subscription to user', () async {
        // act
        await sut.execute(
          fundId: '1',
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        verify(() => mockUserRepository.addActiveSubscription(any())).called(1);
      });

      test('should call getFundById after subscription', () async {
        // act
        await sut.execute(
          fundId: '1',
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        verify(() => mockFundsRepository.getFundById('1')).called(1);
      });
    });

    group('when balance is insufficient', () {
      test('should throw InsufficientBalanceException', () async {
        // arrange
        final userWithLowBalance = tUser.copyWith(balance: 50000);
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => userWithLowBalance);

        // act & assert
        expect(
          () => sut.execute(
            fundId: '1',
            name: tFund.name,
            minimumAmount: tFund.minimumAmount,
          ),
          throwsA(isA<InsufficientBalanceException>()),
        );
      });
    });

    group('when fund is already subscribed', () {
      test('should throw AlreadySubscribedException', () async {
        // arrange
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUserAlreadySubscribed);

        // act & assert
        expect(
          () => sut.execute(
            fundId: '1',
            name: tFund.name,
            minimumAmount: tFund.minimumAmount,
          ),
          throwsA(isA<AlreadySubscribedException>()),
        );
      });
    });
  });
}
