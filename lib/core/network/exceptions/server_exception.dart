/// Exception thrown when the server responds with an error.
///
/// Raised in the network layer when the API endpoint returns an error status.
class ServerException implements Exception {
  /// Creates a [ServerException] with the given [message] and optional [statusCode].
  const ServerException({
    this.message = 'Error del servidor.',
    this.statusCode,
  });

  /// The error message describing the server error.
  final String message;

  /// The HTTP status code associated with the server response.
  final int? statusCode;
}
