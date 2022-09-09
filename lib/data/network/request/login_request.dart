import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  String username;
  String password;

  LoginRequest({
    required this.username,
    required this.password
  });
  
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  /// Connect the generated [_$LoginRequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}