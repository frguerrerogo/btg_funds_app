import 'package:btg_funds_app/core/core.dart' show getHistoryUseCaseProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart' show GetHistoryUseCase;
import 'package:btg_funds_app/features/transaction/presentation/controllers/transaction_state.dart'
    show TransactionState;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_controller.g.dart';

/// Controller that manages [TransactionState] state for the transaction feature.
@riverpod
class TransactionController extends _$TransactionController {
  late GetHistoryUseCase _getHistoryUseCase;

  /// Initializes the controller and loads transaction history on mount.
  @override
  Future<TransactionState> build() async {
    _getHistoryUseCase = ref.read(getHistoryUseCaseProvider);
    return _loadState();
  }

  /// Loads transaction history from the server.
  Future<TransactionState> _loadState() async {
    final transactions = await _getHistoryUseCase.execute();
    return TransactionState(transactions: transactions);
  }

  /// Refreshes the transaction history from the server.
  Future<void> refreshHistory() async {
    if (!ref.mounted) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadState);
  }
}
