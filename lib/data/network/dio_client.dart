import 'package:blocapptest/data/network/end_point.dart';
import 'package:blocapptest/data/network/interceptor/auth.dart';
import 'package:blocapptest/data/network/interceptor/logging.dart';
import 'package:dio/dio.dart';

class DioClient{
  final Dio _dio ;
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = EndPoint.baseUrl
      ..options.connectTimeout = EndPoint.connectionTimeout
      ..options.receiveTimeout = EndPoint.receiveTimeout
      ..interceptors.addAll(
        [
          // LogInterceptor(),
          Auth()
        ]
      );
  }

  Dio getDio(){
    return _dio;
  }
}