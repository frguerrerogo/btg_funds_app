import 'package:btg_funds_app/features/funds/domain/domain.dart'
    show FundCategory, FundEntity, FundsRepository, GetFundsUseCase;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [FundsRepository] used for testing purposes.
///
/// This test double allows tests to control the behavior of the repository
/// without accessing actual data sources.
class MockFundsRepository extends Mock implements FundsRepository {}

void main() {
  /// The system under test: [GetFundsUseCase] instance being tested.
  late GetFundsUseCase sut;

  /// Mock instance of [FundsRepository] used to control repository behavior during tests.
  late MockFundsRepository mockFundsRepository;

  /// Test data representing a realistic set of available funds in the investment platform.
  ///
  /// This fixture includes five funds across both FPV and FIC categories with
  /// varying minimum investment amounts, representing a typical product catalog
  /// scenario for fund retrieval tests.
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

    test('should return fpv and fic funds', () async {
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
