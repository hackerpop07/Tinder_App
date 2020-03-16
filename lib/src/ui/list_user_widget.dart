import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tinderapp/src/bloc/list_user_bloc.dart';

class ListUserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListUserWidgetState();
  }
}

class _ListUserWidgetState extends State<ListUserWidget> {
  @override
  void initState() {
    super.initState();
    listUserBloc.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
      stream: listUserBloc.listUser.stream,
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
          return  _buildNotificationWidget();
          }
          return _buildListUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildNotificationWidget();
        }
      },
    );
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

  Widget _buildNotificationWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Không có dữ liệu", style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

  Widget _buildListUserWidget(List data) {
    List peoples = data;
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          child: Scrollbar(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: peoples.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                            title: Text(
                                "${_capitalizeFirstLetter(peoples[index].name.first)}"
                                " ${_capitalizeFirstLetter(peoples[index].name.last)}"),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Phone : ${peoples[index].phone} "),
                                Text("Cell : ${peoples[index].cell}"),
                                Text("Email : ${peoples[index].email}")
                              ],
                            ),
                            leading: new CircleAvatar(
                              backgroundImage:
                                  NetworkImage(peoples[index].picture),
                              radius: 30,
                            )),
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                }),
          )),
    );
  }

  _capitalizeFirstLetter(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(0, text.length);
  }
}
