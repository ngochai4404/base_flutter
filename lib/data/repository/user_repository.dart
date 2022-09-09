import 'dart:convert';

import 'package:blocapptest/data/network/api/user_api.dart';
import 'package:blocapptest/data/network/exception/dio_exception.dart';
import 'package:blocapptest/data/network/request/login_request.dart';
import 'package:blocapptest/data/network/response/login_response.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final UserApi userApi;

  UserRepository(this.userApi);

  Future<String> login(String username, String password) async {
    try {
      final response = await userApi
          .login(LoginRequest(username: username, password: password));
      print(response.data);
      return response.data['jwt'];
    } on DioError catch (ex) {
      throw DioExceptions.fromDioError(ex);
    }
  }

  Future<String> getUserInfo() async {
    try {
      final response = await userApi.getUserInfo();
      final Map<String, dynamic> data = json.decode(response.data);
      return data['name'];
    } on DioError catch (ex) {
      throw DioExceptions.fromDioError(ex);
    }
  }
}
