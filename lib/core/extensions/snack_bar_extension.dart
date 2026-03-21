import 'package:flutter/material.dart';

/// Extension on BuildContext to display snack bars globally.
extension SnackBarExtension on BuildContext {
  /// Shows a snack bar with the given [message] and [backgroundColor].
  void showSnackBar(
    String message, {
    Color backgroundColor = Colors.grey,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
      ),
    );
  }

  /// Shows a success snack bar.
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  /// Shows an error snack bar.
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.red);
  }

  /// Shows a warning snack bar.
  void showWarningSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.orange);
  }

  /// Shows an info snack bar.
  void showInfoSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.blue);
  }
}
