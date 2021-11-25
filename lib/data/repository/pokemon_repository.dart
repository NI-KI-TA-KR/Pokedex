import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:poke_app/data/models/control_page.dart';
import 'package:poke_app/data/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/locator.dart';

abstract class PokemonRepository{
   Future<List<Pokemon>> getPokemons({String? url}); 
   Future<PokemonInfo> getPokemonInfo(String id);
}

class PokemonRepositoryImpl implements PokemonRepository{

  @override
  Future<PokemonInfo> getPokemonInfo(String id) async{
    final uri = Uri.https(UrlPoint.startPoint, UrlPoint.getAboutPokemonsEndPoint(id));
    final response = await http.get(uri);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return PokemonInfo.fromJson(data); 
    }
    
    throw Exception("Status code is not 200");
  }

  @override
  Future<List<Pokemon>> getPokemons({String? url}) async {
    
    late Uri uri;
    
    if(url != null){
      uri = Uri.parse(url);
    } else{
      uri = Uri.https(UrlPoint.startPoint, UrlPoint.getListPokemonsEndPoint);    
    }

    final response = await http.get(uri);

    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body)['results'];

      sl<ControlPage>().previous = jsonDecode(response.body)['previous'];
      sl<ControlPage>().next = jsonDecode(response.body)['next'];

      final List<Future<Pokemon>> futuresList = data.map((json) async{
        final id = _getId(json['url']);
        final color = await _getColor(id); 
        return Pokemon.fromJson(json, id, color);
      }).toList();

      return Future.wait(futuresList);
    } 

    throw Exception("Status code is not 200");
  }


  Future<List<Color>> _getColor(String id) async{
    final urlImage = UrlPoint.getImage(id);

    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.network(urlImage).image,
    );
    return [ 
      paletteGenerator.paletteColors[0].color,
      paletteGenerator.paletteColors[1].color,
    ];
  }

  String _getId(String url){
    final list = url.split("/");
    return list[list.length-2];
  }

}

class UrlPoint{
  UrlPoint._();

  static const String startPoint = "pokeapi.co";

  static const String getListPokemonsEndPoint = "/api/v2/pokemon";

  static String getImage(String id){
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  static String getColorEndPoint(String id){
    return "/api/v2/pokemon-species/$id";
  }

  static String getAboutPokemonsEndPoint(String id){
    return "api/v2/pokemon/$id/";
  }
}
