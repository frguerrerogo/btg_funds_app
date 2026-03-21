import 'package:btg_funds_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A centered error message with an optional retry action.
///
/// Provides a simple UI to communicate recoverable failures.
class AppStateErrorWidget extends StatelessWidget {
  /// Creates a [AppStateErrorWidget] with the given [message].
  /// Creates a [AppStateErrorWidget] with the given [onRetry].
  const AppStateErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
  });

  /// Text shown to describe the error state.
  final String message;

  /// Optional [VoidCallback] invoked when the user taps retry.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
