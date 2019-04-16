library home_state;

import 'package:built_value/built_value.dart';

part 'home_state.g.dart';

abstract class HomeState implements Built<HomeState, HomeStateBuilder> {
  int get pageIndex;

  HomeState._();
  factory HomeState({
    int pageIndex = 0,
  }) =>
      _$HomeState._(
        pageIndex: pageIndex,
      );
}
