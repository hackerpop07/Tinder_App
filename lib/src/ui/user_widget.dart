import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinderapp/src/model/user_response.dart';
import 'package:tinderapp/src/bloc/user_bloc.dart';
import 'package:swipedetector/swipedetector.dart';
import '../model/user.dart';

class UserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserWidgetState();
  }
}

class _UserWidgetState extends State<UserWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final loading = null;

  @override
  void initState() {
    super.initState();
    userBloc.getUser();
    _controller = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: userBloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          if (snapshot.hasData == loading) {
            return _buildLoadingWidget();
          }
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error",
            style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

  Widget _buildUserWidget(UserResponse data) {
    User user = data.results[0];
    return SwipeDetector(
      child: Container(
//          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Color(0xfff9f9f9),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 350,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFf9f9f9),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFe2e2e2),
                                                  width: 1)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 20, 30, 30),
                                      child: Container(
                                        width: 172.0,
                                        height: 172.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xffc7c7c7))),
                                        child: Container(
                                            width: 170.0,
                                            height: 170.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 3,
                                                    color: Colors.white),
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: new NetworkImage(
                                                        user.picture)))),
                                      ),
                                    ),
                                  ),
                                  tapBarView(user),
                                  tapBar(),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onSwipeLeft: () {
        userBloc.setUser(loading);
        userBloc.getUser();
      },
      onSwipeRight: () {
        userBloc.addUser(user);
        userBloc.setUser(loading);
        userBloc.getUser();
      },
    );
  }

  Container tapBarView(User user) {
    return new Container(
      height: 80.0,
      child: new TabBarView(
        controller: _controller,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "My name is",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  "${_capitalizeFirstLetter(user.name.first)} ${_capitalizeFirstLetter(user.name.last)}",
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "My SSN is",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  user.SSN,
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "My addres is",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  user.location.street,
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "My phone is",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  user.phone,
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  "My password is",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  user.password,
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container tapBar() {
    return new Container(
//      decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
      child: SizedBox(
        width: 250,
        child: new TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xff92b262), width: 3.0),
            insets: EdgeInsets.fromLTRB(50.0, 0.0, 35.0, 45.0),
          ),
          indicatorColor: Color(0xff92b262),
          labelColor: Color(0xff92b262),
          unselectedLabelColor: Color(0xffd8d8d8),
          controller: _controller,
          tabs: [
            new Tab(
              icon: Icon(
                Icons.account_circle,
                size: 35,
              ),
            ),
            new Tab(
              icon: Icon(
                Icons.assignment,
                size: 35,
              ),
            ),
            new Tab(
              icon: Icon(
                Icons.edit_location,
                size: 35,
              ),
            ),
            new Tab(
              icon: Icon(
                Icons.dialer_sip,
                size: 35,
              ),
            ),
            new Tab(
              icon: Icon(
                Icons.lock,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(0, text.length);
  }
}
