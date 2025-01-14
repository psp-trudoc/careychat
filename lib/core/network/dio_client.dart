import 'package:carey/core/constants/app_keys.dart';
import 'package:carey/core/network/token_interceptor.dart';
import 'package:carey/core/observers/network_observer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static Dio configureDio() {
    final dio = Dio();
    // TODO: need to fetch it from env
    dio.options.baseUrl = "https://chat.wellthy.me";//dotenv.get(AppKeys.apiBaseUrl);
    dio.interceptors.addAll(
        [TokenInterceptor(), NetworkObserver()]);
    return dio;
  }
}
