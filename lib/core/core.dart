/// Core layer barrel file.
///
/// Exports shared utilities, constants, and infrastructure components that are
/// used across all features in the application. This module serves as the
/// central point for accessing core layer abstractions and provides essential
/// shared functionality.
///
/// Exports:
/// - Constants: Application-wide constants and configuration values
/// - Network: HTTP client and networking utilities (Dio)
/// - Shared: Common utilities including data mappers and transformers
library;

export 'constants/app_constants.dart';
export 'network/network.dart';
export 'shared/mapper.dart';
