import 'package:btg_funds_app/core/core.dart'
    show NetworkException, ServerException, TimeoutException;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Intercepts and converts HTTP errors to application-level exceptions.
/// Maps DioException types to domain-specific exception types with descriptive messages.
class ErrorInterceptor extends Interceptor {
  /// Creates an [ErrorInterceptor].
  ErrorInterceptor();

  final _logger = Logger();

  /// Categorizes [DioException] errors and converts to application-level exceptions.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        _logger.w('Network: Connection timeout - took too long to establish connection');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const TimeoutException(
              message: 'Conexión lenta. Verifique su internet.',
            ),
            type: err.type,
          ),
        );
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        _logger.w('Network: Request timeout - server took too long to respond');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const TimeoutException(
              message: 'Servidor lento. Intente de nuevo.',
            ),
            type: err.type,
          ),
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        _logger.e('Network: Server error - HTTP $statusCode');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: ServerException(
              statusCode: statusCode,
              message: _getServerErrorMessage(statusCode),
            ),
            type: err.type,
          ),
        );
      case DioExceptionType.connectionError:
        _logger.w('Network: No internet connection');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(
              'Sin conexión. Verifique su internet.',
            ),
            type: err.type,
          ),
        );
      case DioExceptionType.badCertificate:
        _logger.e('Network: SSL certificate error');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(
              'Error de seguridad. Contacte soporte.',
            ),
            type: err.type,
          ),
        );
      case DioExceptionType.cancel:
        _logger.w('Network: Request cancelled');
        handler.reject(err);
      case DioExceptionType.unknown:
        _logger.e('Network: Unknown error - ${err.message}');
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(
              'Error inesperado. Intente de nuevo.',
            ),
            type: err.type,
          ),
        );
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
