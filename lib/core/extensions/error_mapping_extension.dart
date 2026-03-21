import 'package:btg_funds_app/core/core.dart'
    show NetworkException, ServerException, TimeoutException;

/// Extension for mapping technical exceptions to user-friendly messages.
extension ErrorMappingExtension on Object {
  /// Maps a technical exception to a user-friendly error message.
  ///
  /// Handles different exception types and returns appropriate messages:
  /// - [TimeoutException] or [NetworkException]: Connection-related message
  /// - [ServerException]: Server error message
  /// - Other errors: Generic error message
  String mapTechnicalErrorToMessage() {
    if (this is TimeoutException || this is NetworkException) {
      return 'Revisa tu conexión a internet';
    }

    if (this is ServerException) {
      return 'Error del servidor. Intenta más tarde';
    }

    return 'Ocurrió un error inesperado';
  }
}
