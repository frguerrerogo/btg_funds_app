/// Network layer barrel file.
///
/// Exports HTTP client management and network utilities from the core layer.
/// This module provides centralized access to HTTP communication infrastructure,
/// including the Dio-based HTTP client, custom exceptions, and request/response
/// interceptors for logging and error handling.
///
/// Exports:
/// - Dio client: Pre-configured HTTP client with base URL and timeouts
/// - Network exceptions: Custom exception types for network error handling
/// - Interceptors: Request/response logging and error handling interceptors
library;

export 'dio_client.dart';
export 'exceptions/network_exception.dart';
export 'interceptors/error_interceptor.dart';
export 'interceptors/logging_interceptor.dart';
