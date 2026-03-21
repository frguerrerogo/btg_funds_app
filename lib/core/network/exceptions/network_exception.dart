/// Exception thrown when network connectivity or communication fails.
///
/// Raised in the network layer when HTTP requests encounter network-level errors.
class NetworkException implements Exception {
  /// Creates a [NetworkException] with the given [message].
  const NetworkException(this.message);

  /// The error message describing the network failure.
  final String message;

  /// Returns a string representation including the [message].
  @override
  String toString() => 'NetworkException: $message';
}
