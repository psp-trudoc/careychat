import 'package:carey/core/constants/app_keys.dart';
import 'package:carey/core/network/token_interceptor.dart';
import 'package:carey/core/observers/network_observer.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static Dio configureDio() {
    final dio = Dio();
    dio.options.baseUrl = dotenv.get(AppKeys.apiBaseUrl);
    dio.interceptors.addAll(
        [TokenInterceptor(), NetworkObserver(), ChuckerDioInterceptor()]);
    return dio;
  }
}
