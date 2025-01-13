import 'package:carey/core/loggers/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

class NetworkObserver extends Interceptor with UiLoggy {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info(
        'NetworkObserver', 'Request: ${options.method} ${options.uri}');
    AppLogger.info('NetworkObserver ', ' Request headers: ${options.headers}');
    if (options.data != null) {
      AppLogger.info('NetworkObserver ', ' Request body: ${options.data}');
      if (options.data is FormData) {
        printFormData(options.data);
      }
      logDebug(options.data);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info('NetworkObserver',
        'Response: ${response.statusCode} ${response.requestOptions.uri}');
    AppLogger.info('NetworkObserver', 'Response data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.info('NetworkObserver', 'Error: ${err.type} ${err.message}');
    if (err.response != null) {
      AppLogger.info(
          'NetworkObserver', 'Error response data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}

void printFormData(FormData formData) {
  // Iterate through FormData fields and print them
  for (var field in formData.fields) {
    AppLogger.info('NetworkObserver ', '${field.key}: ${field.value}');
  }
}
