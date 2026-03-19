import 'package:btg_funds_app/core/core.dart' show DioClient;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the [DioClient] instance used across the app.
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});
