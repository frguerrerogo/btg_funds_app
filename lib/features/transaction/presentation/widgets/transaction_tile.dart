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

  String _formatCOP(double amount) {
    return NumberFormat.currency(
      locale: 'es_CO',
      symbol: r'COP $',
      decimalDigits: 0,
    ).format(amount);
  }

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
                color: isSubscription ? const Color(0xFFEAF3DE) : const Color(0xFFFCEBEB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isSubscription ? Icons.arrow_downward : Icons.arrow_upward,
                color: isSubscription ? const Color(0xFF27500A) : const Color(0xFFA32D2D),
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
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isSubscription ? const Color(0xFF27500A) : const Color(0xFFA32D2D),
                    ),
                  ),
                  Text(
                    transaction.fundName,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Notificación: ${transaction.notificationMethod == NotificationMethod.email ? 'Email' : 'SMS'}',
                    style: TextStyle(
                      fontSize: 12,
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
                  '${isSubscription ? '-' : '+'}${_formatCOP(transaction.amount)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: isSubscription ? const Color(0xFFA32D2D) : const Color(0xFF27500A),
                  ),
                ),
                Text(
                  _formatDate(transaction.createdAt),
                  style: TextStyle(
                    fontSize: 11,
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
