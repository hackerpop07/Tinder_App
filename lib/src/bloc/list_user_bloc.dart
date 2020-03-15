import 'package:rxdart/rxdart.dart';
import 'package:tinderapp/src/model/user.dart';

class ListUserBloc {
  final BehaviorSubject<List> _listUser = BehaviorSubject<List>();

  getUsers() {
    List users = listUser.value;
    return users;
  }

  addUser(User user) {
    List users = getUsers();
    if (users == null) {
      users = [];
    }
    if(!users.contains(user)){
      users.add(user);
      listUserBloc.listUser.add(users);
    }
  }

  dispose() {
    _listUser.close();
  }

  BehaviorSubject<List> get listUser => _listUser;
}

final listUserBloc = ListUserBloc();
