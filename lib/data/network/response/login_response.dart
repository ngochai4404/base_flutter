import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponse {
  String jwt;

  LoginResponse({required this.jwt});
}
