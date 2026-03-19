import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:btg_funds_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:btg_funds_app/features/transaction/domain/usecases/get_history_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Mock implementation of [TransactionRepository] for testing purposes.
class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  /// The system under test: [GetHistoryUseCase].
  late GetHistoryUseCase sut;

  /// Mock of [TransactionRepository] injected into [sut].
  late MockTransactionRepository mockTransactionRepository;

  /// Base [TransactionEntity] fixtures with subscription and cancellation operations.
  final tTransactions = [
    TransactionEntity(
      id: '1',
      fundId: '1',
      fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
      amount: 75000,
      type: TransactionType.subscription,
      notificationMethod: NotificationMethod.email,
      createdAt: DateTime.parse('2024-01-01T00:00:00.000'),
    ),
    TransactionEntity(
      id: '2',
      fundId: '1',
      fundName: 'FPV_BTG_PACTUAL_RECAUDADORA',
      amount: 75000,
      type: TransactionType.cancellation,
      notificationMethod: NotificationMethod.sms,
      createdAt: DateTime.parse('2024-01-02T00:00:00.000'),
    ),
  ];

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    sut = GetHistoryUseCase(mockTransactionRepository);
  });

  group('GetHistoryUseCase', () {
    test('should return list of transactions from repository', () async {
      // arrange
      when(() => mockTransactionRepository.getHistory()).thenAnswer((_) async => tTransactions);

      // act
      final result = await sut.execute();

      // assert
      expect(result, tTransactions);
      verify(() => mockTransactionRepository.getHistory()).called(1);
    });

    test('should return empty list when no transactions', () async {
      // arrange
      when(() => mockTransactionRepository.getHistory()).thenAnswer((_) async => []);

      // act
      final result = await sut.execute();

      // assert
      expect(result, isEmpty);
    });

    test('should return subscriptions and cancellations', () async {
      // arrange
      when(() => mockTransactionRepository.getHistory()).thenAnswer((_) async => tTransactions);

      // act
      final result = await sut.execute();

      // assert
      expect(result.where((t) => t.isSubscription).length, 1);
      expect(result.where((t) => t.isCancellation).length, 1);
    });
  });
}
