import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/data/repository/pokemon_repository.dart';
import 'package:poke_app/locator.dart';
import 'package:poke_app/redux/store.dart';
import 'package:redux/redux.dart';
import '../data_state.dart';

class SetDataInfoStateAction{
  final DataState<PokemonInfo> dataState;

  SetDataInfoStateAction({required this.dataState});
}

Future<void> fetchDataInfoAction(Store<AppState> store, String id) async{
  store.dispatch(SetDataInfoStateAction(dataState: DataState(state: Stage.loading)));
  try{
    PokemonInfo pokemonInfo = await sl<PokemonRepository>().getPokemonInfo(id);
    store.dispatch(SetDataInfoStateAction(dataState: DataState(state: Stage.loaded, data: [pokemonInfo])));
  } catch(_){
    store.dispatch(SetDataInfoStateAction(dataState: DataState(state: Stage.error)));
  }
}
