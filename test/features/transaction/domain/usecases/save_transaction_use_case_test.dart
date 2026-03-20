import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show
        NotificationMethod,
        SaveTransactionUseCase,
        TransactionEntity,
        TransactionRepository,
        TransactionType;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [TransactionRepository] for testing purposes.
class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  /// The system under test: [SaveTransactionUseCase].
  late SaveTransactionUseCase sut;

  /// Mock of [TransactionRepository] injected into [sut].
  late MockTransactionRepository mockTransactionRepository;

  /// Base [TransactionEntity] fixture with subscription type and email notification method.
  final tTransaction = TransactionEntity(
    id: '1',
    fundId: '1',
    fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
    amount: 75000,
    type: TransactionType.subscription,
    notificationMethod: NotificationMethod.email,
    createdAt: DateTime.parse('2024-01-01T00:00:00.000'),
  );

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    sut = SaveTransactionUseCase(mockTransactionRepository);
  });

  group('SaveTransactionUseCase', () {
    test('should save transaction to repository', () async {
      // arrange
      when(
        () => mockTransactionRepository.saveTransaction(tTransaction),
      ).thenAnswer((_) async => tTransaction);

      // act
      final result = await sut.execute(tTransaction);

      // assert
      expect(result, tTransaction);
      verify(() => mockTransactionRepository.saveTransaction(tTransaction)).called(1);
    });

    test('should return saved transaction', () async {
      // arrange
      when(
        () => mockTransactionRepository.saveTransaction(tTransaction),
      ).thenAnswer((_) async => tTransaction);

      // act
      final result = await sut.execute(tTransaction);

      // assert
      expect(result.id, tTransaction.id);
      expect(result.type, TransactionType.subscription);
      expect(result.notificationMethod, NotificationMethod.email);
    });
  });
}
