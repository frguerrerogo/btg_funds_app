/// Exception thrown when a network request exceeds the timeout limit.
///
/// Raised in the network layer when the client does not receive a response within the specified duration.
class TimeoutException implements Exception {
  /// Creates a [TimeoutException] with the given [message].
  const TimeoutException({
    this.message = 'Tiempo de espera agotado.',
  });

  /// The error message describing the timeout occurrence.
  final String message;
}
