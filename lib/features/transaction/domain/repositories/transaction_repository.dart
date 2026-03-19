import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';

/// Defines the domain contract for managing transaction history and persistence.
///
/// This repository interface abstracts the data access layer for financial transactions,
/// allowing clients to retrieve transaction history and persist new transaction records
/// without depending on specific storage or retrieval implementations.
abstract class TransactionRepository {
  /// Retrieves the complete transaction history for the investor.
  ///
  /// Returns a list of [TransactionEntity] records sorted by [DateTime] in descending order,
  /// with the most recent transactions appearing first.
  Future<List<TransactionEntity>> getHistory();

  /// Persists a new transaction record to the repository.
  ///
  /// The [transaction] parameter contains all necessary transaction details including
  /// fund identification, amount, operation type, and notification preferences.
  /// Returns the persisted [TransactionEntity] reflecting any system-generated or
  /// server-assigned values such as the transaction identifier and creation timestamp.
  Future<TransactionEntity> saveTransaction(TransactionEntity transaction);
}
