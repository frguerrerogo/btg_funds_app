import 'package:btg_funds_app/features/transaction/domain/domain.dart'
    show TransactionEntity, TransactionRepository;

/// Encapsulates the business logic for retrieving transaction history.
///
/// This use case orchestrates the retrieval of all financial transactions
/// executed by the investor, delegating the actual data access to the injected
/// [TransactionRepository]. The transactions are sorted chronologically with
/// the most recent operations appearing first.
class GetHistoryUseCase {
  /// Creates a new instance of [GetHistoryUseCase].
  ///
  /// The [repository] parameter provides the data access interface for
  /// retrieving transaction records from the system.
  const GetHistoryUseCase(TransactionRepository repository) : _repository = repository;

  final TransactionRepository _repository;

  /// Retrieves the complete transaction history for the investor.
  ///
  /// Returns a list of [TransactionEntity] records sorted by creation date
  /// in descending order, with the most recent transactions appearing first.
  Future<List<TransactionEntity>> execute() async {
    return _repository.getHistory();
  }
}
