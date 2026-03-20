import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String _formatCOP(double amount) {
    return NumberFormat.currency(
      locale: 'es_CO',
      symbol: r'COP $',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF003087),
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
                    color: Color(0xFF93B3E0),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatCOP(balance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
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
                  color: Color(0xFF93B3E0),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$subscribedCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
