import 'package:poke_app/redux/data_info/data_info_actions.dart';

import '../data_state.dart';

DataState dataInfoReducer(DataState prevState, SetDataInfoStateAction action){
  final DataState payload = action.dataState;
  return prevState.copyWith(
    state: payload.state,
    data: payload.data
  );
}