import 'package:flutter/material.dart';

extension StringTypeToColor on String{
  Color toColor(){
    if(this == "normal"){
      return Color.fromRGBO(194, 185, 122,1);
    }
    if(this == "fighting"){
      return Color.fromRGBO(240, 63, 43, 1);
    }
    if(this == "flying"){
      return Color.fromRGBO(21, 203, 235, 1);
    }
    if(this == "poison"){
      return Color.fromRGBO(55, 105, 52, 1);
    }
    if(this == "ground"){
      return Color.fromRGBO(56, 52, 53, 1);
    }
    if(this == "rock"){
      return Color.fromRGBO(109, 133, 129, 1);
    }
    if(this == "bug"){
      return Colors.green;
    }
    if(this == "ghost"){
      return Color.fromRGBO(169, 176, 175, 1);
    }
    if(this == "steel"){
      return Color.fromRGBO(111, 130, 138, 1);
    }
    if(this == "fire"){
      return Colors.red;
    } 
    if(this == "water"){
      return Colors.blue;
    } 
    if(this == "grass"){
      return Colors.green;
    } 
    if(this == "electric"){
      return Colors.yellow;
    } 
    if(this == "psychic"){
      return Colors.orange;
    } 
    if(this == "ice"){
      return Colors.lightBlue;
    } 
    if(this == "dragon"){
      return Colors.red;
    } 
    if(this == "dark"){
      return Colors.black;
    } 
    if(this == "fairy"){
      return Colors.pink;
    } 
    if(this == "unknown"){
      return Colors.brown;
    } 
    if(this == "shadow"){
      return Colors.grey;
    } 
    return Colors.amber;
  }
}