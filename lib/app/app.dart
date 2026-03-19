import 'package:flutter/material.dart';

/// The root widget of the application.
///
/// Provides the MaterialApp entry point for the UI.
class App extends StatelessWidget {
  /// Creates an [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
