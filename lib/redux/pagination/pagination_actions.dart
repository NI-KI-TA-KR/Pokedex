import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/data/repository/pokemon_repository.dart';
import 'package:poke_app/locator.dart';
import 'package:poke_app/redux/store.dart';
import 'package:redux/redux.dart';
import '../data_state.dart';

class PaginationStateAction{
  final DataState<Pokemon> dataState;

  PaginationStateAction({required this.dataState});
}

Future<void> fetchDataPaginationAction(Store<AppState> store, String? url) async{
  store.dispatch(PaginationStateAction(dataState: DataState(state: Stage.loading)));
  if(url != null){
      List<Pokemon> newPokemons = await sl<PokemonRepository>().getPokemons(url: url);
      store.dispatch(PaginationStateAction(dataState: DataState(state: Stage.loaded, data: newPokemons)));
    } 
}

class StateData{
  StateData._();

  static List<Pokemon> pokemons = [];
  static bool isLoading = false;
}
