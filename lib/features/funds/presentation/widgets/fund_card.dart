import 'package:btg_funds_app/core/extensions/currency_formatter.dart';
import 'package:btg_funds_app/core/theme/app_colors.dart';
import 'package:btg_funds_app/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  'Monto mínimo: ${fund.minimumAmount.formatCOP()}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Align(
              child: SizedBox(
                width: 130,
                child: fund.isSubscribed
                    ? OutlinedButton.icon(
                        onPressed: onCancel,
                        icon: const Icon(Icons.cancel_outlined, size: 18),
                        label: const Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 1.5,
                          ),
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: onSubscribe,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'Suscribirse',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              ),
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
        color: isFpv ? AppColors.fpvBg : AppColors.ficBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isFpv ? 'FPV' : 'FIC',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isFpv ? AppColors.fpvText : AppColors.ficText,
        ),
      ),
    );
  }
}
