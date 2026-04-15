import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocey/core/constants/preference_manager.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get token from preference manager if available
    final String? token = PreferenceManager().getString('auth_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Clear user data on unauthorized error
      PreferenceManager().clear();
    }

    handler.next(err);
  }
}