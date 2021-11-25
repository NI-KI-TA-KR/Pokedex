import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/extension/extension_color.dart';
import 'package:poke_app/redux/data_info/data_info_actions.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:poke_app/redux/data_state.dart';
import 'package:poke_app/redux/store.dart';
import 'package:poke_app/utils/style.dart';
import 'package:redux/redux.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AboutPokemonPage extends StatefulWidget {
  AboutPokemonPage({required this.pokemon});

  final Pokemon pokemon;

  @override
  State<AboutPokemonPage> createState() => _AboutPokemonPageState();
}

class _AboutPokemonPageState extends State<AboutPokemonPage> {
  @override
  void initState() {
    Redux.store.dispatch(fetchDataInfoAction(Redux.store, widget.pokemon.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.pokemon.color.first,
        elevation: 0,
        title: Text("Pokedex"),
      ),
      body: StoreConnector<AppState, Stage>(
        distinct: true,
        converter: (Store<AppState> store) => store.state.dataInfoState.state!,
        builder: (context, Stage state) {
          switch (state) {
            case Stage.loading:
              return _loadingState();
            case Stage.loaded:
              return _loadedState();
            case Stage.error:
            default:
              return _errorState();
          }
        },
      ),
    );
  }

  Widget _loadingState() {
    return Container();
  }

  Widget _loadedState() {
    return StoreConnector<AppState, PokemonInfo>(
      distinct: true,
      converter: (Store<AppState> store) =>
          store.state.dataInfoState.data!.first as PokemonInfo,
      builder: (context, info) {
        return Container(
          height: 100.h,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                height: 60.w,
                width: 100.w,
                child: Image.network(
                  widget.pokemon.image,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.w),
                    bottomRight: Radius.circular(10.w),
                  ),
                  gradient: LinearGradient(
                    colors: widget.pokemon.color,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.pokemon.name,
                      style: TextStyles.styleBlack18Bold.copyWith(fontSize: 25.sp),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3.w),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                        onTap: _sound,
                        child: Icon(Icons.headphones, size: 8.w, color: Colors.red,)
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.only(top: .w),
                child: TypesWidget(types: info.types!),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.w),
                child: HeightWeightWidget(
                  height: info.height!,
                  weight: info.weight!,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.w),
                child: BaseStatsWidget(
                  info: info,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _errorState() {
    return Container();
  }

  _sound() async{
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(10);
    await flutterTts.speak(widget.pokemon.name);
  }
}

class TypesWidget extends StatelessWidget {
  TypesWidget({required this.types});

  final List<String> types;

  List<Widget> _buildList() {
    return types
        .map((type) => Container(
              margin: EdgeInsets.all(2.w),
              alignment: Alignment.center,
              width: 35.w,
              height: 8.w,
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyles.styleBlack18Bold.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              decoration: BoxDecoration(
                color: type.toColor(),
                borderRadius: BorderRadius.circular(10.w),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildList(),
      ),
    );
  }
}

class BaseStatsWidget extends StatelessWidget {
  BaseStatsWidget({required this.info});

  final PokemonInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Base Stats",
            style: TextStyles.styleBlack18Bold,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 7.w),
            child: IndicatorWidget(
                text: "HP", percent: info.hp!, color: Colors.red),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.w),
            child: IndicatorWidget(
                text: "AT", percent: info.attack!, color: Colors.orange),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.w),
            child: IndicatorWidget(
                text: "DEF", percent: info.deference!, color: Colors.blue),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.w),
            child: IndicatorWidget(
                text: "SPD", percent: info.speed!, color: Colors.grey),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.w),
            child: IndicatorWidget(
                text: "EXP",
                percent: info.baseExperience!,
                color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class HeightWeightWidget extends StatelessWidget {
  HeightWeightWidget({required this.height, required this.weight});

  final int height;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "${weight * 0.1}".substring(0, 3) + " KG",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.w),
                child: Text(
                  "Weight",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "${height * 0.1}".substring(0, 3) + " M",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.w),
                child: Text(
                  "Height",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  IndicatorWidget({
    required this.text,
    required this.percent,
    required this.color,
  });

  final String text;
  final int percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyles.styleBlack18Normal
                .copyWith(color: Colors.grey, fontSize: 14.sp),
          ),
          Container(
            margin: EdgeInsets.only(left: 2.w),
            child: LinearPercentIndicator(
              width: 70.w,
              lineHeight: 5.w,
              percent: percent * 100 / 300 * 0.01,
              backgroundColor: Colors.grey.withOpacity(0.4),
              progressColor: color,
              center: Text(
                "$percent/300",
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
              animation: true,
              animationDuration: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
