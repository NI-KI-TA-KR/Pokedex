import 'package:get_it/get_it.dart';
import 'package:poke_app/data/repository/pokemon_repository.dart';
import 'data/models/control_page.dart';

final sl = GetIt.instance;

void setup(){
  sl.registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl());
  sl.registerLazySingleton<ControlPage>(() => ControlPage());
}