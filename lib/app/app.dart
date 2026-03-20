import 'package:btg_funds_app/app/router/app_router.dart' show appRouter;
import 'package:btg_funds_app/core/core.dart' show AppTheme;
import 'package:flutter/material.dart';

/// The root widget of the application.
///
/// Provides the MaterialApp entry point for the UI.
class App extends StatelessWidget {
  /// Creates an [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BTG Funds',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
