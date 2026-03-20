import 'package:flutter/material.dart';

/// A centered circular loading indicator.
///
/// Provides a lightweight placeholder while content is loading.
class LoadingWidget extends StatelessWidget {
  /// Creates a [LoadingWidget].
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
