import 'package:flutter/material.dart';
import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/pages/about_pokemon.page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';

class PokemonWidget extends StatelessWidget {
  PokemonWidget({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AboutPokemonPage(
                pokemon: pokemon,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: pokemon.image,
                placeholder: (context, url) => Container(
                  padding: EdgeInsets.all(5.w),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 25.w,
              ),
              Container(
                margin: EdgeInsets.only(top: 3.w),
                child: Text(
                  pokemon.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
            gradient: LinearGradient(colors: pokemon.color),
          ),
        ),
      ),
    );
  }
}
