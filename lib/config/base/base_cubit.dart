import 'dart:async';

import 'package:blocapptest/config/base/rx.dart';
import 'package:blocapptest/exceptions/app_exception.dart';
import 'package:blocapptest/widgets/views/state_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseCubit<BaseState> extends BlocBase<BaseState> {
  BaseCubit(BaseState initialState) : super(initialState);

  final List<dynamic> loadMoreList = [];

  final BehaviorSubject<List<dynamic>> loadMoreListController =
  BehaviorSubject();

  Stream<List<dynamic>> get loadMoreListStream => loadMoreListController.stream;

  int loadMorePage = 1;
  bool canLoadMore = true;
  bool loadMoreRefresh = true;
  bool loadMoreLoading = false;

  final BehaviorSubject<StateLayout> _state =
  BehaviorSubject<StateLayout>.seeded(StateLayout.showContent);
  final _canLoadMoreSub = BehaviorSubject<bool>.seeded(false);

  final _errMsg = BehaviorSubject<AppException>.seeded(AppException("",""));

  Stream<bool> get loadMoreStream => _canLoadMoreSub.stream;

  Sink<bool> get loadMoreSink => _canLoadMoreSub.sink;

  Stream<StateLayout> get stateStream => _state.stream;

  Stream<AppException> get errMsg => _errMsg.stream;

  void updateStateError() {
    _state.sink.add(StateLayout.showError);
  }

  void showLoading() {
    _state.wellAdd(StateLayout.showLoading);
  }

  void showError(String title, String error) {
    _errMsg.sink.add(AppException(title,error));
    _state.wellAdd(StateLayout.showError);
  }

  void showEmpty() {
    _state.wellAdd(StateLayout.showEmpty);
  }

  void showContent() {
    _state.wellAdd(StateLayout.showContent);
  }
}
