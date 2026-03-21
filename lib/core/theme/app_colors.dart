import 'package:flutter/material.dart';

/// Centralized color palette for the BTG Funds App
class AppColors {
  // Primary colors
  /// Primary brand color - dark blue
  static const Color primary = Color(0xFF003377);

  /// Light variant of primary color
  static const Color primaryLight = Color(0xFF003087);

  // Error/Alert colors
  /// Error state color - dark red
  static const Color error = Color(0xFFA32D2D);

  /// Light background color for error states
  static const Color errorLight = Color(0xFFFCEBEB);

  /// Error border color
  static const Color errorBorder = Color(0xFFF09595);

  // Transaction colors
  /// Subscription background color
  static const Color subscriptionBg = Color(0xFFEAF3DE);

  /// Subscription text color
  static const Color subscriptionText = Color(0xFF27500A);

  /// Cancellation background color (same as errorLight)
  static const Color cancellationBg = Color(0xFFFCEBEB);

  /// Cancellation text color (same as error)
  static const Color cancellationText = Color(0xFFA32D2D);

  // Fund category colors
  /// FPV category background color
  static const Color fpvBg = Color(0xFFE6F1FB);

  /// FPV category text color
  static const Color fpvText = Color(0xFF0C447C);

  /// FIC category background color
  static const Color ficBg = Color(0xFFEAF3DE);

  /// FIC category text color
  static const Color ficText = Color(0xFF27500A);

  // Semantic colors
  /// Success state color
  static const Color success = Color(0xFF4CAF50);

  /// Warning state color
  static const Color warning = Color(0xFFFFC107);

  /// Info state color
  static const Color info = Color(0xFF2196F3);

  // Neutral colors
  /// White color
  static const Color white = Color(0xFFFFFFFF);

  /// Black color
  static const Color black = Color(0xFF000000);

  /// Grey color
  static const Color grey = Color(0xFF757575);

  /// Light grey color
  static const Color greyLight = Color(0xFFF5F5F5);

  /// Dark grey color
  static const Color greyDark = Color(0xFF424242);

  // Text colors
  /// Primary text color
  static const Color textPrimary = Color(0xFF212121);

  /// Secondary text color
  static const Color textSecondary = Color(0xFF757575);

  /// Hint text color
  static const Color textHint = Color(0xFFBDBDBD);
}
