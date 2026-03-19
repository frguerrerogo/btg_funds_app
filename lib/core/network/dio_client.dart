import 'package:btg_funds_app/core/core.dart' show AppConstants;
import 'package:btg_funds_app/core/network/network.dart' show ErrorInterceptor, LoggingInterceptor;
import 'package:dio/dio.dart';

/// HTTP client wrapper that configures [Dio] with base URL,
/// timeouts, default headers, and core interceptors.
class DioClient {
  /// Creates a [DioClient] and initializes the [Dio] instance.
  DioClient() : _dio = _createDio();

  final Dio _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
    return dio;
  }

  /// The configured [Dio] instance ready for use.
  Dio get dio => _dio;
}
