import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_app/data/models/control_page.dart';
import 'package:poke_app/data/models/pokemon.dart';
import 'package:poke_app/locator.dart';
import 'package:poke_app/redux/data_state.dart';
import 'package:poke_app/redux/pagination/pagination_actions.dart';
import 'package:poke_app/redux/store.dart';
import 'package:poke_app/redux/data/data_actions.dart';
import 'package:poke_app/widgets/pokemon_widget.dart';
import 'package:redux/redux.dart';
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  void initState() {
    Redux.store.dispatch(fetchDataAction);
    super.initState();
  }

   void _loadData() async {
    if(sl<ControlPage>().next != null){
      await Redux.store.dispatch(fetchDataPaginationAction(Redux.store, sl<ControlPage>().next));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(
          "Pokedex",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            StoreConnector<AppState, Stage>(
              distinct: true,
              converter: (Store<AppState> store) =>
                  store.state.dataState.state!,
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
          ],
        ),
      ),
    );
  }

  Widget _loadingState() {
    return Container(
      height: 82.h,
      margin: EdgeInsets.only(left: 24.w),
      child: Lottie.asset("assets/loading.json", height: 50.w, width: 50.w),
    );
  }

  Widget _loadedState() {
    return Container(
      child: StoreConnector<AppState, List<Pokemon>>(
            distinct: false,
            converter: (Store<AppState> store){
              if(StateData.pokemons.isEmpty){
                StateData.pokemons.addAll(store.state.dataState.data as List<Pokemon>);
              } else {
                if(store.state.dataPaginationState.state == Stage.loaded){
                  final pokemons = store.state.dataPaginationState.data as List<Pokemon>;
                  StateData.pokemons.addAll(pokemons);
                  StateData.isLoading = false;
                }
               
              }
              return StateData.pokemons;
            },
            builder: (context, List<Pokemon> pokemons) {
              return Container(
                height: 88.h,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification){
                    if(!StateData.isLoading && scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent){
                      StateData.isLoading = true;
                      _loadData();
                      return false;
                    }
                    return false;
                  },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3/3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: StateData.pokemons.length,
                  itemBuilder: (context, index){
                    return PokemonWidget(pokemon: pokemons[index]);
                  }
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _errorState() {
    return Container(
      margin: EdgeInsets.all(30.w),
      child: Icon(Icons.error),
    );
  }
}
