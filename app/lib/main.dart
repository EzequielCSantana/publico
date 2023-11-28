import 'package:app/pages/login/login.dart';
import 'package:app/splashscreen.dart';
import 'package:flutter/material.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        //theme: theme,
        debugShowCheckedModeBanner: false,
        title: "Target",
        home: new SplashPage(),
        routes: <String,WidgetBuilder>{
          //pgAbertura
          'abertura':(BuildContext context) => new login()
        }
    );
  }


}

