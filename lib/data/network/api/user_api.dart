
import 'package:blocapptest/data/network/dio_client.dart';
import 'package:blocapptest/data/network/end_point.dart';
import 'package:blocapptest/data/network/request/login_request.dart';
import 'package:dio/dio.dart';

class UserApi {
  final DioClient dioClient;

  UserApi(this.dioClient);

  Future<Response> login(LoginRequest request) async {
      final Response response = await dioClient.getDio().post(
          EndPoint.login,
          data: request
      );
      return response ;
  }

  Future<Response> getUserInfo() async {
    final Response response = await dioClient.getDio().get(
        EndPoint.user
    );
    return response ;
  }
}