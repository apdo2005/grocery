import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('╔════════════════════════════════════════════════════════════');
    log('║ 🚀 REQUEST');
    log('║ ────────────────────────────────────────────────────────────');
    log('║ Method: ${options.method}');
    log('║ URL: ${options.uri}');
    log('║ Headers: ${options.headers}');

    if (options.queryParameters.isNotEmpty) {
      log('║ Query Parameters: ${options.queryParameters}');
    }

    if (options.data != null) {
      log('║ Body: ${options.data}');
    }

    log('╚════════════════════════════════════════════════════════════');

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    log('╔════════════════════════════════════════════════════════════');
    log('║ ✅ RESPONSE');
    log('║ ────────────────────────────────────────────────────────────');
    log('║ Status Code: ${response.statusCode}');
    log('║ URL: ${response.requestOptions.uri}');

    final responseData = response.data.toString();
    if (responseData.length > 500) {
      log('║ Data: ${responseData.substring(0, 500)}... (truncated)');
    } else {
      log('║ Data: $responseData');
    }

    log('╚════════════════════════════════════════════════════════════');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('╔════════════════════════════════════════════════════════════');
    log('║ ❌ ERROR');
    log('║ ────────────────────────────────────────────────────────────');
    log('║ Method: ${err.requestOptions.method}');
    log('║ URL: ${err.requestOptions.uri}');
    log('║ Error Type: ${err.type}');
    log('║ Error Message: ${err.message}');
    log('║ Status Code: ${err.response?.statusCode}');

    if (err.requestOptions.queryParameters.isNotEmpty) {
      log('║ Query Parameters: ${err.requestOptions.queryParameters}');
    }

    if (err.requestOptions.data != null) {
      log('║ Body: ${err.requestOptions.data}');
    }

    if (err.response?.data != null) {
      log('║ Error Data: ${err.response?.data}');
    }

    log('╚════════════════════════════════════════════════════════════');

    handler.next(err);
  }
}
