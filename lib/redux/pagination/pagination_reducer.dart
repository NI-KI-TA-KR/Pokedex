import 'package:poke_app/redux/pagination/pagination_actions.dart';
import '../data_state.dart';

DataState paginationReducer(DataState prevState, PaginationStateAction action){
  final DataState payload = action.dataState;
  return prevState.copyWith(
    state: payload.state,
    data: payload.data
  );
}