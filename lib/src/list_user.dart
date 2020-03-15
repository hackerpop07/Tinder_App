import 'package:flutter/material.dart';
import 'package:tinderapp/src/ui/list_user_widget.dart';

class ListUserPage extends StatefulWidget {
  ListUserPage({Key key}) : super(key: key);

  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Peoples",
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListUserWidget(),
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
    );
  }
}
