import 'package:flutter/material.dart';
import 'package:poke_app/redux/data/data_actions.dart';
import 'package:poke_app/redux/data/data_reducer.dart';
import 'package:poke_app/redux/data_info/data_info_actions.dart';
import 'package:poke_app/redux/data_info/data_info_reducer.dart';
import 'package:poke_app/redux/data_state.dart';
import 'package:poke_app/redux/pagination/pagination_actions.dart';
import 'package:poke_app/redux/pagination/pagination_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState appReducer(AppState state, dynamic action){
  if(action is SetDataStateAction){
    final nextDataState = dataReducer(state.dataState, action);
    return state.copyWith(dataState: nextDataState);
  }
  if(action is SetDataInfoStateAction){
    final nextDataState = dataInfoReducer(state.dataState, action);
    return state.copyWith(dataInfoState: nextDataState);
  }
  if(action is PaginationStateAction){
    final nextDataState = paginationReducer(state.dataState, action);
    return state.copyWith(dataPaginationState: nextDataState);
  }
  return state;
}


@immutable
class AppState{
  final DataState dataState;
  final DataState dataInfoState;
  final DataState dataPaginationState;

  AppState({
    required this.dataState,
    required this.dataInfoState,
    required this.dataPaginationState
  });

  AppState copyWith({DataState? dataState, DataState? dataInfoState, DataState? dataPaginationState}){
    return AppState(
      dataState: dataState ?? this.dataState,
      dataInfoState: dataInfoState ?? this.dataInfoState,
      dataPaginationState: dataPaginationState ?? this.dataPaginationState,
    );
  }
}

class Redux{
  static late Store<AppState> _store;

  static Store<AppState> get store{
    if(_store == null){
      throw Exception("store is not initialized");
    }
    else{
      return _store;
    }
  }

  static Future<void> init() async{
    _store = Store<AppState>(
      appReducer, middleware: [thunkMiddleware],
      initialState: AppState(dataState: DataState.initial(), dataInfoState: DataState.initial(), dataPaginationState: DataState.initial()),
    );
  }
}