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
      options.headers[AppKeys.authorizationHeader] = 'Bearer $token';
    }
    return options;
  }

  RequestOptions addAppHeader(RequestOptions options) {
    // final String appTypeValue = dotenv.get(AppKeys.nexusAppType);
    // options.headers[AppKeys.appName] = F.appName;
    // final appInfo = getIt<AppInfo>();
    // options.headers[AppKeys.appVersion] = appInfo.version;
    // options.headers[AppKeys.apiAppFlavor] = F.apiAppFlavor;
    // final String appCurrentLocale = pref.getString(AppKeys.appCurrentLocale);
    // options.headers[AppKeys.language] = appCurrentLocale.isNotEmpty
    //     ? appCurrentLocale
    //     : LanguageState.en().locale.languageCode;
    // options.headers[AppKeys.xSource] = AppKeys.xSourceValue;
    // options.headers[AppKeys.appType] = appTypeValue;
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
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = err.response?.data['error_code'];
    if (error == HttpStatus.unauthorized) {}
    super.onError(err, handler);
  }
}
