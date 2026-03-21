import 'package:flutter/material.dart';

/// Extension on BoxConstraints for responsive design utilities.
extension ResponsiveExtension on BoxConstraints {
  /// Calculates horizontal padding based on screen width.
  ///
  /// Returns responsive padding:
  /// - Width > 1200px: 15% of width
  /// - Width > 800px: 10% of width
  /// - Width <= 800px: 16px
  double get responsiveHorizontalPadding {
    if (maxWidth > 1200) {
      return maxWidth * 0.15;
    } else if (maxWidth > 800) {
      return maxWidth * 0.10;
    }
    return 16;
  }
}
