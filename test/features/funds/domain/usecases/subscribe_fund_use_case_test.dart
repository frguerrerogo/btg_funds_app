// test/features/funds/domain/usecases/subscribe_fund_use_case_test.dart

import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        FundCategory,
        FundEntity,
        InsufficientBalanceException,
        SubscribeFundUseCase;
import 'package:btg_funds_app/features/user/domain/domain.dart'
    show ActiveSubscriptionEntity, UserEntity, UserRepository;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [UserRepository] for testing purposes.
class MockUserRepository extends Mock implements UserRepository {}

/// Fake implementation of [ActiveSubscriptionEntity] for mocktail registration.
class FakeActiveSubscriptionEntity extends Fake implements ActiveSubscriptionEntity {}

void main() {
  /// The system under test: [SubscribeFundUseCase].
  late SubscribeFundUseCase sut;

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

  /// [UserEntity] fixture with updated balance after subscription.
  final tUserUpdated = UserEntity(
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
    mockUserRepository = MockUserRepository();
    sut = SubscribeFundUseCase(
      userRepository: mockUserRepository,
    );
  });

  group('SubscribeFundUseCase', () {
    group('when balance is sufficient', () {
      setUp(() {
        when(
          () => mockUserRepository.updateBalance(425000),
        ).thenAnswer((_) async => tUser.copyWith(balance: 425000));
        when(
          () => mockUserRepository.addActiveSubscription(any()),
        ).thenAnswer((_) async => tUserUpdated);
      });

      test('should update user balance after subscription', () async {
        // act
        await sut.execute(
          user: tUser,
          fundId: tFund.id,
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        verify(() => mockUserRepository.updateBalance(425000)).called(1);
      });

      test('should add active subscription to user', () async {
        // act
        await sut.execute(
          user: tUser,
          fundId: tFund.id,
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        verify(() => mockUserRepository.addActiveSubscription(any())).called(1);
      });

      test('should return updated user with subscription', () async {
        // act
        final result = await sut.execute(
          user: tUser,
          fundId: tFund.id,
          name: tFund.name,
          minimumAmount: tFund.minimumAmount,
        );

        // assert
        expect(result.balance, 425000);
        expect(result.activeSubscriptions.length, 1);
        expect(result.activeSubscriptions.first.fundId, '1');
      });
    });

    group('when balance is insufficient', () {
      test('should throw InsufficientBalanceException', () async {
        // arrange
        final userWithLowBalance = tUser.copyWith(balance: 50000);

        // act & assert
        expect(
          () => sut.execute(
            user: userWithLowBalance,
            fundId: tFund.id,
            name: tFund.name,
            minimumAmount: tFund.minimumAmount,
          ),
          throwsA(isA<InsufficientBalanceException>()),
        );
      });
    });

    group('when fund is already subscribed', () {
      test('should throw AlreadySubscribedException', () async {
        // act & assert
        expect(
          () => sut.execute(
            user: tUserAlreadySubscribed,
            fundId: tFund.id,
            name: tFund.name,
            minimumAmount: tFund.minimumAmount,
          ),
          throwsA(isA<AlreadySubscribedException>()),
        );
      });
    });
  });
}
