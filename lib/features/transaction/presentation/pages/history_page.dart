import 'package:btg_funds_app/core/core.dart'
    show AppStateErrorWidget, LoadingWidget, ResponsiveExtension;
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
    final state = ref.watch(transactionControllerProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.responsiveHorizontalPadding;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Historial de transacciones'),
            centerTitle: true,
          ),
          body: state.when(
            data: (historyState) {
              if (historyState.transactions.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: const Center(
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
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
                itemCount: historyState.transactions.length,
                itemBuilder: (context, index) => TransactionTile(
                  transaction: historyState.transactions[index],
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
      },
    );
  }
}
