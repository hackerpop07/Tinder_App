import 'package:flutter/material.dart';
import 'package:tinderapp/src/bloc/user_bloc.dart';
import 'package:tinderapp/src/model/user.dart';
import 'package:tinderapp/src/ui/user_widget.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:tinderapp/src/utils/globals.dart' as globals;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Tinder",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/list_user");
              }),
        ],
      ),
      body: SwipeDetector(
        child: Container(
          child: UserWidget(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
              colors: [
                Color(0xFFF12711),
                Color(0xFFff5454),
              ],
            ),
          ),
        ),
        onSwipeLeft: () {
          setState(() {
            globals.loading = true;
          });
          userBloc.getUser();
        },
        onSwipeRight: () {
          User user = userBloc.subject.value.results[0];
          userBloc.addUser(user);
          setState(() {
            globals.loading = true;
          });
          userBloc.getUser();
        },
      ),
    );
  }
}
