// lib/core/widgets/app_error_widget.dart

import 'package:btg_funds_app/app/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A not-found error screen for invalid routes.
///
/// Provides a recovery action that navigates back to the default destination.
class AppErrorWidget extends StatelessWidget {
  /// Creates a [AppErrorWidget] with the given [state].
  const AppErrorWidget({
    required this.state,
    super.key,
  });

  /// Route state used to display the failing URI.
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página no encontrada')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text('Ruta no encontrada: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => const FundsRoute().go(context),
              child: const Text('Ir a inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
