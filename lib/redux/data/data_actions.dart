import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/data/repository/pokemon_repository.dart';
import 'package:poke_app/locator.dart';
import 'package:poke_app/redux/store.dart';
import 'package:redux/redux.dart';
import '../data_state.dart';

class SetDataStateAction{
  final DataState<Pokemon> dataState;

  SetDataStateAction({required this.dataState});
}

Future<void> fetchDataAction(Store<AppState> store) async{
    store.dispatch(SetDataStateAction(dataState: DataState(state: Stage.loading)));
  try{
    List<Pokemon> newPokemons = await sl<PokemonRepository>().getPokemons();
    store.dispatch(SetDataStateAction(dataState: DataState(state: Stage.loaded, data: newPokemons)));
  } catch(_){
    store.dispatch(SetDataStateAction(dataState: DataState(state: Stage.error)));
  }
}
