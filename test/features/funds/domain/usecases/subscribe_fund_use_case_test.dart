// test/features/funds/domain/usecases/subscribe_fund_use_case_test.dart

import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show
        AlreadySubscribedException,
        FundCategory,
        FundEntity,
        FundsRepository,
        InsufficientBalanceException,
        SubscribeFundUseCase;
import 'package:btg_funds_app/features/user/domain/domain.dart' show UserEntity, UserRepository;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFundsRepository extends Mock implements FundsRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late SubscribeFundUseCase sut;
  late MockFundsRepository mockFundsRepository;
  late MockUserRepository mockUserRepository;

  const tFund = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
  );

  const tUser = UserEntity(
    id: '1',
    name: 'BTG User',
    balance: 500000,
  );

  const tSubscribedFund = FundEntity(
    id: '1',
    name: 'FPV_BTG_PACTUAL_RECAUDADORA',
    minimumAmount: 75000,
    category: FundCategory.fpv,
    isSubscribed: true,
  );

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
        when(() => mockFundsRepository.subscribeFund('1')).thenAnswer((_) async => tSubscribedFund);
        when(
          () => mockUserRepository.updateBalance(425000),
        ).thenAnswer((_) async => tUser.copyWith(balance: 425000));
        when(() => mockUserRepository.addSubscribedFund('1')).thenAnswer((_) async => tUser);
      });

      test('should return subscribed fund', () async {
        // act
        final result = await sut.execute(fundId: '1');

        // assert
        expect(result.isSubscribed, true);
        verify(() => mockFundsRepository.subscribeFund('1')).called(1);
      });

      test('should update user balance after subscription', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.updateBalance(425000)).called(1);
      });

      test('should add fund to user subscriptions', () async {
        // act
        await sut.execute(fundId: '1');

        // assert
        verify(() => mockUserRepository.addSubscribedFund('1')).called(1);
      });
    });

    group('when balance is insufficient', () {
      test('should throw InsufficientBalanceException', () async {
        // arrange
        final userWithLowBalance = tUser.copyWith(balance: 50000);
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => userWithLowBalance);
        when(() => mockFundsRepository.getFundById('1')).thenAnswer((_) async => tFund);

        // act & assert
        expect(
          () => sut.execute(fundId: '1'),
          throwsA(isA<InsufficientBalanceException>()),
        );
      });
    });

    group('when fund is already subscribed', () {
      test('should throw AlreadySubscribedException', () async {
        // arrange
        when(() => mockUserRepository.getUser()).thenAnswer((_) async => tUser);
        when(() => mockFundsRepository.getFundById('1')).thenAnswer((_) async => tSubscribedFund);

        // act & assert
        expect(
          () => sut.execute(fundId: '1'),
          throwsA(isA<AlreadySubscribedException>()),
        );
      });
    });
  });
}
