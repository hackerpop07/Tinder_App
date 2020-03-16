import 'package:rxdart/rxdart.dart';
import 'package:tinderapp/src/repository/user_repository.dart';

class ListUserBloc {
  final BehaviorSubject<List> _listUser = BehaviorSubject<List>();
  final UserRepository _repository = UserRepository();

  getUsers() {
      _repository.getAllUser().then((users) {
          listUser.sink.add(users);
      }).catchError((onError) {});
  }

  dispose() {
    _listUser.close();
  }

  BehaviorSubject<List> get listUser => _listUser;
}

final listUserBloc = ListUserBloc();
