import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show TransactionEntity, TransactionRepository;

/// Use case that retrieves the user's transaction history.
///
/// Depends on [TransactionRepository] for transaction history retrieval.
class GetHistoryUseCase {
  /// Creates a [GetHistoryUseCase] with [repository].
  const GetHistoryUseCase(TransactionRepository repository) : _repository = repository;

  final TransactionRepository _repository;

  /// Retrieves all transactions for the user. Returns a list of [TransactionEntity] ordered by creation date in descending order.
  Future<List<TransactionEntity>> execute() async {
    return _repository.getHistory();
  }
}
