import 'package:btg_funds_app/core/network/network.dart' show NetworkException;
import 'package:dio/dio.dart';

/// Intercepts and converts HTTP errors to application-level exceptions. Extends [Interceptor] to centralize error handling.
class ErrorInterceptor extends Interceptor {
  /// Creates an [ErrorInterceptor].
  ErrorInterceptor();

  /// Categorizes [DioException] errors and throws appropriate [NetworkException].
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw const NetworkException('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        throw NetworkException('Server error: ${err.response?.statusCode}');
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        throw const NetworkException('Unexpected error. Please try again.');
    }
  }
}
