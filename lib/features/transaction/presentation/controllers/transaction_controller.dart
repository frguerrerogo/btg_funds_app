import 'package:btg_funds_app/core/core.dart'
    show getHistoryUseCaseProvider, transactionRepositoryProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show GetHistoryUseCase, TransactionEntity, TransactionRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controller that manages [List<TransactionEntity>] state for the transaction feature.
class TransactionController extends AsyncNotifier<List<TransactionEntity>> {
  late GetHistoryUseCase _getHistoryUseCase;
  late TransactionRepository _transactionRepository;

  /// Initializes the controller and loads transaction history on mount.
  @override
  Future<List<TransactionEntity>> build() async {
    _getHistoryUseCase = ref.read(getHistoryUseCaseProvider);
    _transactionRepository = ref.read(transactionRepositoryProvider);
    return _getHistoryUseCase.execute();
  }

  /// Saves a new transaction and refreshes the transaction history.
  Future<void> saveTransaction(TransactionEntity transaction) async {
    await AsyncValue.guard(
      () => _transactionRepository.saveTransaction(transaction),
    );
    // Refresh history
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getHistoryUseCase.execute());
  }

  /// Refreshes the transaction history from the server.
  Future<void> refreshHistory() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getHistoryUseCase.execute());
  }
}

/// Provider for [TransactionController].
final transactionControllerProvider =
    AsyncNotifierProvider<TransactionController, List<TransactionEntity>>(
      TransactionController.new,
    );
