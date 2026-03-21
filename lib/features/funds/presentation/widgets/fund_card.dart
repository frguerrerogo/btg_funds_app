import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A card that displays a fund summary with a primary action.
///
/// Provides an at-a-glance view for browsing funds and triggering subscription actions.
class FundCard extends StatelessWidget {
  /// Creates a [FundCard] with the given [fund], [onSubscribe], and [onCancel].
  const FundCard({
    required this.fund,
    required this.onSubscribe,
    required this.onCancel,
    super.key,
  });

  /// Fund information presented in the card.
  final FundEntity fund;

  /// Action invoked when the user chooses to subscribe.
  final VoidCallback onSubscribe;

  /// Action invoked when the user chooses to cancel a subscription.
  final VoidCallback onCancel;

  String _formatCOP(double amount) {
    return NumberFormat.currency(
      locale: 'es_CO',
      symbol: r'COP $',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    fund.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                _CategoryBadge(category: fund.category),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Monto mínimo: ${_formatCOP(fund.minimumAmount)}',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            if (fund.isSubscribed)
              OutlinedButton.icon(
                onPressed: onCancel,
                icon: const Icon(Icons.cancel_outlined, size: 16),
                label: const Text('Cancelar suscripción'),
              )
            else
              ElevatedButton.icon(
                onPressed: onSubscribe,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Suscribirse'),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});

  final FundCategory category;

  @override
  Widget build(BuildContext context) {
    final isFpv = category == FundCategory.fpv;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isFpv ? const Color(0xFFE6F1FB) : const Color(0xFFEAF3DE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isFpv ? 'FPV' : 'FIC',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isFpv ? const Color(0xFF0C447C) : const Color(0xFF27500A),
        ),
      ),
    );
  }
}
