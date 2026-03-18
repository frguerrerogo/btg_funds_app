import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

/// The root widget of the application.
///
/// This is the entry point of the BTG Funds application. It sets up the
/// Material Design theme and defines the base navigation structure for
/// the entire app using [MaterialApp].
class MainApp extends StatelessWidget {
  /// Creates the root widget instance.
  ///
  /// The [key] parameter is passed to the parent [StatelessWidget].
  const MainApp({super.key});

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
