import 'package:blocapptest/utils/prefs_service.dart';
import 'package:dio/dio.dart';

class Auth extends Interceptor {
  // Obtain shared preferences.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = PrefsService.getToken();
    if(token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer " + token;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }
}