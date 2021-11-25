import 'package:flutter/material.dart';
import 'package:poke_app/data/repository/pokemon_repository.dart';

class Pokemon{
  final String id;
  final String name;
  final List<Color> color;
  String get image => UrlPoint.getImage(id);

  Pokemon({
    required this.id,
    required this.name,
    required this.color,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, String id, List<Color> color){
    return Pokemon(
      id: id,
      name: json['name'],
      color: color,
    );
  }
}

class PokemonInfo{
  final List<String>? types;
  final int? weight;
  final int? height;
  final int? hp;
  final int? attack;
  final int? deference;
  final int? speed;
  final int? baseExperience;

  PokemonInfo({
    this.attack,
    this.baseExperience,
    this.deference,
    this.height,
    this.hp,
    this.speed,
    this.types,
    this.weight,
  });

    factory PokemonInfo.fromJson(Map<String, dynamic> json){
    
    List<dynamic> types = json['types'];

    return PokemonInfo(
      hp: json['stats'][0]['base_stat'],
      attack: json['stats'][1]['base_stat'], 
      deference: json['stats'][2]['base_stat'],  
      speed: json['stats'][5]['base_stat'],
      baseExperience: json['base_experience'], 
      height: json['height'],
      weight: json['weight'],
      types: types.map<String>((type) => type['type']['name']).toList(),
    );
  }
}