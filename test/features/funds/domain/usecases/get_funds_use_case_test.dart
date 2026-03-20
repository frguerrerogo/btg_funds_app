import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show FundCategory, FundEntity, FundsRepository, GetFundsUseCase;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [FundsRepository] for testing purposes.
class MockFundsRepository extends Mock implements FundsRepository {}

void main() {
  /// The system under test: [GetFundsUseCase].
  late GetFundsUseCase sut;

  /// Mock of [FundsRepository] injected into [sut].
  late MockFundsRepository mockFundsRepository;

  /// Base [List<FundEntity>] fixture with 5 funds across FPV and FIC categories with minimum amounts from 50,000 to 250,000 COP.
  final tFunds = [
    const FundEntity(
      id: '1',
      name: 'FPV_BTG_PACTUAL_RECAUDADORA',
      minimumAmount: 75000,
      category: FundCategory.fpv,
    ),
    const FundEntity(
      id: '2',
      name: 'FPV_BTG_PACTUAL_ECOPETROL',
      minimumAmount: 125000,
      category: FundCategory.fpv,
    ),
    const FundEntity(
      id: '3',
      name: 'DEUDAPRIVADA',
      minimumAmount: 50000,
      category: FundCategory.fic,
    ),
    const FundEntity(
      id: '4',
      name: 'FDO-ACCIONES',
      minimumAmount: 250000,
      category: FundCategory.fic,
    ),
    const FundEntity(
      id: '5',
      name: 'FPV_BTG_PACTUAL_DINAMICA',
      minimumAmount: 100000,
      category: FundCategory.fpv,
    ),
  ];

  setUp(() {
    mockFundsRepository = MockFundsRepository();
    sut = GetFundsUseCase(mockFundsRepository);
  });

  group('GetFundsUseCase', () {
    test('should return list of funds from repository', () async {
      // arrange
      when(() => mockFundsRepository.getFunds()).thenAnswer((_) async => tFunds);

      // act
      final result = await sut.execute();

      // assert
      expect(result, tFunds);
      verify(() => mockFundsRepository.getFunds()).called(1);
    });

    test('should return 5 funds', () async {
      // arrange
      when(() => mockFundsRepository.getFunds()).thenAnswer((_) async => tFunds);

      // act
      final result = await sut.execute();

      // assert
      expect(result.length, 5);
    });

    test('should return 3 fpv and 2 fic funds', () async {
      // arrange
      when(() => mockFundsRepository.getFunds()).thenAnswer((_) async => tFunds);

      // act
      final result = await sut.execute();

      // assert
      expect(result.where((f) => f.isFpv).length, 3);
      expect(result.where((f) => f.isFic).length, 2);
    });

    test('should return empty list when no funds available', () async {
      // arrange
      when(() => mockFundsRepository.getFunds()).thenAnswer((_) async => []);

      // act
      final result = await sut.execute();

      // assert
      expect(result, isEmpty);
    });
  });
}
