import 'package:btg_funds_app/core/core.dart'
    show AppColors, AppStateErrorWidget, ErrorMappingExtension, LoadingWidget, ResponsiveExtension;
import 'package:btg_funds_app/features/transaction/presentation/presentation.dart'
    show TransactionState, TransactionTile, transactionControllerProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A transaction history screen with a list of past transactions.
///
/// Provides a simple view for reviewing the user's activity.
class TransactionHistoryPage extends ConsumerWidget {
  /// Creates a [TransactionHistoryPage].
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de transacciones',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, _) => AppStateErrorWidget(
          message: error.mapTechnicalErrorToMessage(),
          onRetry: () => ref.invalidate(transactionControllerProvider),
        ),
        data: _buildContent,
      ),
    );
  }

  Widget _buildContent(TransactionState historyState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.responsiveHorizontalPadding;

        if (historyState.transactions.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No hay transacciones aún',
                    style: TextStyle(color: AppColors.grey),
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
    );
  }
}
