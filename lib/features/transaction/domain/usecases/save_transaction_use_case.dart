import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:btg_funds_app/features/transaction/domain/repositories/transaction_repository.dart';

/// Use case that encapsulates the business logic for saving a new transaction.
///
/// Depends on [TransactionRepository] for persisting transactions to the data layer.
class SaveTransactionUseCase {
  /// Creates a [SaveTransactionUseCase] with [TransactionRepository].
  const SaveTransactionUseCase(TransactionRepository repository) : _repository = repository;

  final TransactionRepository _repository;

  /// Saves a new transaction to the data layer.
  ///
  /// Returns a [TransactionEntity] reflecting the persisted transaction with its assigned identifier.
  ///
  /// Throws an exception if the transaction cannot be persisted.
  Future<TransactionEntity> execute(TransactionEntity transaction) async {
    return _repository.saveTransaction(transaction);
  }
}
