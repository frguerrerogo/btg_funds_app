import 'package:btg_funds_app/core/core.dart' show getHistoryUseCaseProvider;
import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show GetHistoryUseCase, TransactionEntity;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_controller.g.dart';

/// Controller that manages [List<TransactionEntity>] state for the transaction feature.
@riverpod
class TransactionController extends _$TransactionController {
  late GetHistoryUseCase _getHistoryUseCase;

  /// Initializes the controller and loads transaction history on mount.
  @override
  Future<List<TransactionEntity>> build() async {
    _getHistoryUseCase = ref.read(getHistoryUseCaseProvider);
    return _getHistoryUseCase.execute();
  }

  /// Refreshes the transaction history from the server.
  Future<void> refreshHistory() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getHistoryUseCase.execute());
  }
}
