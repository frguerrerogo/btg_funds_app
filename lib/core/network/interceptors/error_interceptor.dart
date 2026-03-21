import 'package:btg_funds_app/core/core.dart'
    show NetworkException, ServerException, TimeoutException;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Intercepts and converts HTTP errors to application-level exceptions.
/// Maps DioException types to domain-specific exception types with descriptive messages.
class ErrorInterceptor extends Interceptor {
  final _logger = Logger();

  /// Categorizes [DioException] errors and converts to application-level exceptions.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        _logger.w('Network: Connection timeout - took too long to establish connection');

        handler.reject(
          err.copyWith(
            error: const TimeoutException(
              message: 'Conexión lenta. Verifique su internet.',
            ),
          ),
        );
        return;

      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        _logger.w('Network: Request timeout - server took too long to respond');

        handler.reject(
          err.copyWith(
            error: const TimeoutException(
              message: 'Servidor lento. Intente de nuevo.',
            ),
          ),
        );
        return;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;

        _logger.e('Network: Server error - HTTP $statusCode');

        handler.reject(
          err.copyWith(
            error: ServerException(
              statusCode: statusCode,
              message: _getServerErrorMessage(statusCode),
            ),
          ),
        );
        return;

      case DioExceptionType.connectionError:
        _logger.w('Network: No internet connection');

        handler.reject(
          err.copyWith(
            error: const NetworkException(
              'Sin conexión. Verifique su internet.',
            ),
          ),
        );
        return;

      case DioExceptionType.badCertificate:
        _logger.e('Network: SSL certificate error');

        handler.reject(
          err.copyWith(
            error: const NetworkException(
              'Error de seguridad. Contacte soporte.',
            ),
          ),
        );
        return;

      case DioExceptionType.cancel:
        _logger.w('Network: Request cancelled');
        handler.reject(err);
        return;

      case DioExceptionType.unknown:
        _logger.e('Network: Unknown error - ${err.message}');

        handler.reject(
          err.copyWith(
            error: const NetworkException(
              'Error inesperado. Intente de nuevo.',
            ),
          ),
        );
        return;
    }
  }

  /// Maps HTTP status codes to user-friendly error messages.
  String _getServerErrorMessage(int? statusCode) {
    return switch (statusCode) {
      400 => 'Solicitud inválida. Intente de nuevo.',
      401 || 403 => 'No autorizado. Inicie sesión de nuevo.',
      404 => 'Recurso no encontrado.',
      429 => 'Demasiadas solicitudes. Intente más tarde.',
      500 || 502 => 'Error del servidor. Intente más tarde.',
      503 => 'Servidor en mantenimiento. Intente más tarde.',
      _ => 'Error del servidor ($statusCode). Intente de nuevo.',
    };
  }
}
