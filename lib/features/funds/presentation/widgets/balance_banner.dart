import 'package:btg_funds_app/core/extensions/currency_formatter.dart';
import 'package:btg_funds_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A header banner that shows the user's available balance.
///
/// Provides a quick summary of balance and subscribed funds on the funds screen.
class BalanceBanner extends StatelessWidget {
  /// Creates a [BalanceBanner] with the given [balance] and [subscribedCount].
  const BalanceBanner({
    required this.balance,
    required this.subscribedCount,
    super.key,
  });

  /// Current available balance displayed in the banner.
  final double balance;

  /// Number of subscribed funds displayed as a summary.
  final int subscribedCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo disponible',
                  style: TextStyle(
                    color: AppColors.bannerLabel,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  balance.formatCOP(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Fondos suscritos',
                style: TextStyle(
                  color: AppColors.bannerLabel,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$subscribedCount',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
