import 'package:intl/intl.dart';

/// Extension to format currency values in Colombian Pesos (COP)
extension CurrencyFormatter on double {
  /// Formats the amount as Colombian Pesos currency
  /// Example: 1000000 -> "COP $1.000.000"
  String formatCOP() {
    return NumberFormat.currency(
      locale: 'es_CO',
      symbol: r'COP $',
      decimalDigits: 0,
    ).format(this);
  }
}
