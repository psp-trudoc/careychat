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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWQiOiJVMkZzZEdWa1gxOXZVY050ZEEvbjRvQndaSGtOVy96Z3BFdzFQZ3UrOGRKemN0MFVpOTI4MENMQUpvY1Z0N01aQllFM1ZjaDFPTmVnQm1aY2xOQzc3TWRJRVJjWHFWY2FiM0FoajdSZkludz0iLCJpYXQiOjE3MzY4NDYyODcsImV4cCI6MTczODE0MjI4N30.N3ErVF5hmszVLB-V8OwK9K_O4SIPchr7slF9uAaVh5U";
    options.headers[AppKeys.apiChecksum] =
        "aHR0cHM6Ly9ibGFkZS53ZWxsdGh5Lm1lL3YzL3NldHRpbmcvdjIvZGF0YS83ODg1My8yMDI1LTAxLTE0VDA5OjIxOjIzWg==";
    options.headers[AppKeys.idToken] =
        "U2FsdGVkX1+p7EA+7KddnmbvOkOjjuNngocgQdEkLPE=";

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
