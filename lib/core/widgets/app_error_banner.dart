import 'package:flutter/material.dart';

/// Displays an error message with a retry action button.
///
/// A visually distinct banner that alerts users to errors and provides a quick way to retry the failed operation.
class AppErrorBanner extends StatelessWidget {
  /// Creates an [AppErrorBanner] with the given [message] and [onRetry] callback.
  const AppErrorBanner({
    required this.message,
    required this.onRetry,
    super.key,
  });

  /// The error message displayed in the banner.
  final String message;

  /// Callback triggered when the retry button is pressed.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFCEBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFF09595),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Color(0xFFA32D2D),
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFFA32D2D),
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFA32D2D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                visualDensity: VisualDensity.compact,
              ),
              child: const Text(
                'Reintentar',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
