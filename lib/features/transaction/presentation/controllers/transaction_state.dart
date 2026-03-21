import 'package:btg_funds_app/features/transaction/domain/domain.dart' show TransactionEntity;
import 'package:equatable/equatable.dart';

/// Represents the state of the transaction screen.
///
/// Encapsulates the list of transactions history.
class TransactionState extends Equatable {
  /// Creates a [TransactionState] with the given [transactions].
  const TransactionState({
    required this.transactions,
  });

  /// The list of transactions.
  final List<TransactionEntity> transactions;

  /// Returns whether there are any transactions.
  bool get hasTransactions => transactions.isNotEmpty;

  /// Returns the list of subscription transactions.
  List<TransactionEntity> get subscriptionTransactions =>
      transactions.where((t) => t.type.toString() == 'TransactionType.subscription').toList();

  /// Returns the list of cancellation transactions.
  List<TransactionEntity> get cancellationTransactions =>
      transactions.where((t) => t.type.toString() == 'TransactionType.cancellation').toList();

  /// Returns a copy of this state with the given fields replaced.
  TransactionState copyWith({
    List<TransactionEntity>? transactions,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [transactions];
}
