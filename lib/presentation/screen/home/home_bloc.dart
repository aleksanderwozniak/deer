import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'home_actions.dart';
import 'home_state.dart';

class HomeBloc {
  Sink get actions => _actions;
  final _actions = StreamController();

  HomeState get initialState => _state.value;
  Stream<HomeState> get state => _state.stream.distinct();
  final _state = BehaviorSubject<HomeState>.seeded(HomeState(pageIndex: 0));

  HomeBloc() {
    _actions.stream.listen((action) {
      _onUpdatePageIndex(action);
    });
  }

  void dispose() {
    _actions.close();
    _state.close();
  }

  void _onUpdatePageIndex(UpdatePageIndex action) {
    _state.add(_state.value.rebuild((b) => b..pageIndex = action.newIndex));
  }
}
