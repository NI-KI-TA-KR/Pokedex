import 'data_actions.dart';
import '../data_state.dart';

DataState dataReducer(DataState prevState, SetDataStateAction action){
  final DataState payload = action.dataState;
  return prevState.copyWith(
    state: payload.state,
    data: payload.data
  );
}