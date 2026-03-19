import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';

/// Repository interface for accessing and managing transaction data.
/// Defines the domain contract for transaction history retrieval and persistence.
abstract class TransactionRepository {
  /// Retrieves the complete transaction history for the current user. Returns a list of [TransactionEntity] records ordered by creation date in descending order.
  Future<List<TransactionEntity>> getHistory();

  /// Persists a new transaction identified by the provided [transaction] data. Returns the [TransactionEntity] reflecting any system-generated values.
  Future<TransactionEntity> saveTransaction(TransactionEntity transaction);
}
