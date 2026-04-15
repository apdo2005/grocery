import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  DioHelper._();

  static late Dio _dio;


  static void init({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    bool enableLogger = true,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _addInterceptors(enableLogger);
  }

  static Dio get dio => _dio;


  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static void clearToken() {
    _token = null;
  }


  static void _addInterceptors(bool enableLogger) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final withAuth = options.extra['withAuth'] == true;

          if (withAuth && _token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }

          options.headers['Accept-Language'] = 'en';

          handler.next(options);
        },
      ),
    );

    if (enableLogger) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.get(
      path,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }

  static Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }


  static Future<Response> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }

  static Future<Response> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: query,
      options: Options(
        extra: {'withAuth': withAuth},
      ),
    );
  }
}