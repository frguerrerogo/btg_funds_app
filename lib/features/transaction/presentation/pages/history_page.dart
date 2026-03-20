import 'package:btg_funds_app/core/core.dart' show AppStateErrorWidget, LoadingWidget;
import 'package:btg_funds_app/features/transaction/presentation/presentation.dart'
    show TransactionTile, transactionControllerProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A transaction history screen with a list of past transactions.
///
/// Provides a simple view for reviewing the user's activity.
class HistoryPage extends ConsumerWidget {
  /// Creates a [HistoryPage].
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(transactionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de transacciones')),
      body: historyState.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No hay transacciones aún',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) => TransactionTile(
              transaction: transactions[index],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) => AppStateErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(transactionControllerProvider),
        ),
      ),
    );
  }
}
