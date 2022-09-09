import 'package:blocapptest/config/base/base_state.dart';
import 'package:blocapptest/model/entries_response.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeState extends BaseState{
  const HomeState();
}

class HomeDataInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeDataLoadSuccess extends HomeState {

  HomeDataLoadSuccess(this.data);

  final String data;

  @override
  List<Object> get props => [data];
}

