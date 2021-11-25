import 'package:flutter/material.dart';

@immutable
class DataState<T>{
  final Stage? state;
  final List<T>? data;

  DataState({
    this.state, this.data
  });

  factory DataState.initial() => DataState(
    state: Stage.none,
    data: [],
  );

  DataState copyWith({Stage? state, List<T>? data}){
    return DataState(
      state: state ?? this.state,
      data: data ?? this.data
    );
  }
}

enum Stage{
  none, loading, loaded, error, pagination
}