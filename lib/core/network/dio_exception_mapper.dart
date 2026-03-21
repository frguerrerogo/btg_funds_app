import 'package:btg_funds_app/core/core.dart'
    show NetworkException, ServerException, TimeoutException;
import 'package:dio/dio.dart';

/// Maps [DioException] to application-level exceptions.
///
/// This mapper centralizes the conversion of Dio exceptions into domain-specific
/// exceptions that can be handled consistently across the application.
class DioExceptionMapper {
  /// Maps a [DioException] to an application-level [Exception].
  ///
  /// If the exception already contains an application-level error,
  /// it returns that directly. Otherwise, it maps based on the exception type.
  static Exception map(DioException e) {
    final error = e.error;

    // If the error is already an Exception, return it directly
    if (error is Exception) {
      return error;
    }

    // Map based on DioException type
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const TimeoutException(
        message: 'Tiempo de espera agotado',
      ),
      DioExceptionType.connectionError => const NetworkException(
        'Sin conexión a internet',
      ),
      DioExceptionType.badResponse => ServerException(
        statusCode: e.response?.statusCode,
        message: 'Error del servidor',
      ),
      _ => const NetworkException(
        'Error inesperado',
      ),
    };
  }
}
