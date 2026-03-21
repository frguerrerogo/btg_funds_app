import 'package:btg_funds_app/core/extensions/currency_formatter.dart';
import 'package:btg_funds_app/core/theme/app_colors.dart';
import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A card-style row that summarizes a single transaction.
///
/// Provides a compact visual representation for transaction history lists.
class TransactionTile extends StatelessWidget {
  /// Creates a [TransactionTile] with the given [transaction].
  const TransactionTile({
    required this.transaction,
    super.key,
  });

  /// Transaction data displayed by this tile.
  final TransactionEntity transaction;

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final isSubscription = transaction.isSubscription;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSubscription ? AppColors.subscriptionBg : AppColors.cancellationBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isSubscription ? Icons.arrow_downward : Icons.arrow_upward,
                color: isSubscription
                    ? AppColors.cancellationTextLight
                    : AppColors.subscriptionTextLight,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSubscription ? 'Suscripción' : 'Cancelación',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: isSubscription
                          ? AppColors.cancellationTextLight
                          : AppColors.subscriptionTextLight,
                    ),
                  ),
                  Text(
                    transaction.fundName,
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Notificación: ${transaction.notificationMethod == NotificationMethod.email ? 'Email' : 'SMS'}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isSubscription ? '-' : '+'}${transaction.amount.formatCOP()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isSubscription
                        ? AppColors.cancellationTextLight
                        : AppColors.subscriptionTextLight,
                  ),
                ),
                Text(
                  _formatDate(transaction.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
