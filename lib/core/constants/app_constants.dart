import 'package:btg_funds_app/core/network/network.dart' show DioClient;

/// Centralizes all static configuration values used across the application.
class AppConstants {
  AppConstants._();

  /// Base URL used by [DioClient] to construct all API request URLs.
  static const String baseUrl = 'http://localhost:3000';

  /// Initial account balance assigned to new user profiles.
  static const double initialBalance = 500000;

  /// Default user identifier used in API requests and user-specific operations.
  static const String userId = '07FG';

  /// Time window for deduplicating error messages in milliseconds.
  /// Prevents showing the same error snackbar multiple times within this duration.
  static const Duration errorDeduplicationWindow = Duration(milliseconds: 500);
}
