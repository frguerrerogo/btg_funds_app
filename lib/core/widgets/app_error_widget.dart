import 'package:btg_funds_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Layout type for error display
enum ErrorWidgetLayout {
  /// Horizontal banner layout with icon, message, and retry button
  banner,

  /// Centered vertical layout with large icon, message, and optional retry button
  centered,
}

/// Unified error widget that displays error messages with optional retry action.
///
/// This widget replaces AppErrorBanner and AppStateErrorWidget, providing
/// a flexible, consistent approach to displaying errors throughout the app.
class AppErrorWidget extends StatelessWidget {
  /// Creates an [AppErrorWidget] with the given [message] and optional [onRetry].
  const AppErrorWidget({
    required this.message,
    this.onRetry,
    this.layout = ErrorWidgetLayout.banner,
    this.maxWidth = 500,
    super.key,
  });

  /// The error message displayed in the widget.
  final String message;

  /// Optional callback triggered when the retry button is pressed.
  final VoidCallback? onRetry;

  /// The layout style for displaying the error.
  final ErrorWidgetLayout layout;

  /// Maximum width constraint for the widget.
  /// Only applies to banner layout.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      ErrorWidgetLayout.banner => _buildBannerLayout(),
      ErrorWidgetLayout.centered => _buildCenteredLayout(),
    };
  }

  Widget _buildBannerLayout() {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.errorBorder,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.error,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text(
                  'Reintentar',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCenteredLayout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
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
