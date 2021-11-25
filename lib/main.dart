import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:poke_app/redux/store.dart';
import 'pages/home_page.dart';
import 'package:sizer/sizer.dart';
import 'locator.dart';

void main() async {
  await Redux.init();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return StoreProvider<AppState>(
        store: Redux.store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pokedex',
          home:  MyHomePage(),
        ),
      );
    });
  }
}
