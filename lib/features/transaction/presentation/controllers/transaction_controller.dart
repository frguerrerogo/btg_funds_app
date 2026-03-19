import 'package:btg_funds_app/core/core.dart'
    show getHistoryUseCaseProvider, transactionRepositoryProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show GetHistoryUseCase, TransactionEntity, TransactionRepository;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_controller.g.dart';

/// Controller that manages [List<TransactionEntity>] state for the transaction feature.
@riverpod
class TransactionController extends _$TransactionController {
  late GetHistoryUseCase _getHistoryUseCase;
  late TransactionRepository _transactionRepository;

  /// Initializes the controller and loads transaction history on mount.
  @override
  Future<List<TransactionEntity>> build() async {
    _getHistoryUseCase = ref.read(getHistoryUseCaseProvider);
    _transactionRepository = ref.read(transactionRepositoryProvider);
    return _getHistoryUseCase.execute();
  }

  /// Saves a new [transaction] to the repository.
  /// Refreshes the transaction history after successful save.
  Future<void> saveTransaction(TransactionEntity transaction) async {
    await AsyncValue.guard(
      () => _transactionRepository.saveTransaction(transaction),
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getHistoryUseCase.execute());
  }

  /// Refreshes the transaction history from the server.
  Future<void> refreshHistory() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getHistoryUseCase.execute());
  }
}
