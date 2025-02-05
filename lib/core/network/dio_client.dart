import 'package:carey/core/network/token_interceptor.dart';
import 'package:carey/core/observers/network_observer.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio configureDio() {
    final dio = Dio();
    // TODO: need to fetch it from env
    // dio.options.baseUrl = "https://64ce-106-51-70-102.ngrok-free.app";
    // dio.options.baseUrl ="https://chat.wellthy.me";
    // dio.options.baseUrl = "http://65.0.117.73:3001";
    // dio.options.baseUrl = dotenv.get(AppKeys.apiBaseUrl);
    dio.options.baseUrl ="https://api.nexus.trudoc.ae";

    dio.interceptors.addAll([TokenInterceptor(), NetworkObserver()]);
    return dio;
  }
}
