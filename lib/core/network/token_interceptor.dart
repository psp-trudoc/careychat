import 'dart:io';

import 'package:carey/bootstrap.dart';
import 'package:carey/core/constants/app_keys.dart';
import 'package:carey/core/utils/app_pref_service.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final pref = getIt<AppPreferenceService>();

  RequestOptions addAuthHeader(RequestOptions options) {
    final token = pref.getString(AppKeys.authToken);
    if (token != '') {
      // options.headers[AppKeys.authorizationHeader] = 'Bearer $token';
    }
    return options;
  }

  RequestOptions addAppHeader(RequestOptions options) {
    options.headers[AppKeys.accessToken] =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWQiOiJVMkZzZEdWa1gxL0M3eFdxeFF3UERMNHROazZzdGZjQXlLN1NDMU5vcldYVmd1QzhFRExlWk9NdUNyS3BCSDJER2xJMkRoWitzNHZuVGRLOXpLbldZVVdzZzRMWjFVQTFrYjBBT09JSW9lQT0iLCJpYXQiOjE3MzY0ODkzMTQsImV4cCI6MTczNzc4NTMxNH0.mRiA6lqVuI0KT3VjAWmzV0_6R6f0_CrmiisWNY6QFC4";
    options.headers[AppKeys.apiChecksum] =
        "aHR0cHM6Ly9jaGF0LndlbGx0aHkubWUvdXNlci9yZWdpc3Rlcg==";
    options.headers[AppKeys.idToken] =
        "U2FsdGVkX19m/K9BWtm+03BXUS9QHkrlFkUEjbmgljQ=";

    return options;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options = addAuthHeader(options);
    options = addAppHeader(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with your response
    print(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = err.response?.data['error_code'];
    if (error == HttpStatus.unauthorized) {}
    super.onError(err, handler);
  }
}
