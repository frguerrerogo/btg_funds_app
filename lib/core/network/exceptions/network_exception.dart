/// Exception thrown when network errors occur during HTTP communication.
///
/// Thrown by the error interceptor for timeouts, bad responses, and other
/// network failures. Implements [Exception] to integrate with Dart's error
/// handling system.
class NetworkException implements Exception {
  /// Creates a [NetworkException] with the given error [message].
  const NetworkException(this.message);

  /// A user-friendly description of the network error.
  final String message;

  /// Returns a string representation including the [message].
  @override
  String toString() => 'NetworkException: $message';
}
