import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show CancelFundUseCase, FundCategory, FundEntity, FundsRepository;
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

  /// Base [ActiveSubscriptionEntity] fixture with fund amount of 75,000 COP and subscription date of 2024-01-01.
  final tActiveSubscription = ActiveSubscriptionEntity(
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    subscribedAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  /// Base [UserEntity] fixture with balance of 425,000 COP and one active subscription.
  final tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 425000,
    activeSubscriptions: [tActiveSubscription],
  );

  /// Base [FundEntity] fixture representing a subscribed FPV fund with minimum amount of 75,000 COP.
  const tSubscribedFund = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
  );

  /// Base [FundEntity] fixture representing a cancelled fund.
  const tCancelledFund = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
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
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);
        when(() => mockFundsRepository.getFundById('1')).thenAnswer((_) async => tSubscribedFund);
        when(() => mockFundsRepository.cancelFund('1')).thenAnswer((_) async => tCancelledFund);
        when(
          () => mockUserRepository.updateBalance(500000),
        ).thenAnswer((_) async => tUser.copyWith(balance: 500000));
        when(() => mockUserRepository.removeSubscribedFund('1')).thenAnswer((_) async => tUser);
      });

      test('should refund amount to user balance', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.updateBalance(500000)).called(1);
      });

      test('should remove fund from user subscriptions', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.removeSubscribedFund('1')).called(1);
      });
    });
  });
}
