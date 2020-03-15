import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinderapp/src/list_user.dart';
import 'package:tinderapp/src/my_home.dart';

void main() => runApp(MyApp());

final routes = {
  '/': (BuildContext context) => new MyHomePage(),
  '/list_user': (BuildContext context) => new ListUserPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(fontSize: 30, color: Colors.white),
            subtitle: TextStyle(fontSize: 20, color: Colors.white),
            body1: TextStyle(fontSize: 15, color: Colors.white),
            display1: TextStyle(color: Color(0xff9a9a9a), fontSize: 18),
            display2: TextStyle(color: Color(0xff2e2f31), fontSize: 30)
          ),

      ),
      routes: routes,
      initialRoute: "/",
    );
  }
}
