import 'package:blocapptest/config/base/base_state.dart';
import 'package:blocapptest/model/entries_response.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginState extends BaseState{
  const LoginState();
}

class LoginDataInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess({required this.token});
  @override
  List<Object> get props => [this.token];
}

