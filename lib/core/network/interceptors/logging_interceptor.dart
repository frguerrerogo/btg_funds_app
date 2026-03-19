import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Logs HTTP requests, responses, and errors for debugging. Extends [Interceptor] to provide visibility into network communication.
class LoggingInterceptor extends Interceptor {
  /// Creates a [LoggingInterceptor] and initializes the [Logger] instance.
  LoggingInterceptor() : _logger = Logger();

  final Logger _logger;

  /// Logs request method and path at debug level, then forwards to [handler].
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('[REQUEST] ${options.method} ${options.path}');
    super.onRequest(options, handler);
  }

  /// Logs response status code and path at info level, then forwards to [handler].
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _logger.i('[RESPONSE] ${response.statusCode} ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  /// Logs error status code and message at error level, then forwards to [handler].
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('[ERROR] ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
