import 'package:rxdart/rxdart.dart';
import 'package:tinderapp/src/model/user.dart';
import 'package:tinderapp/src/model/user_response.dart';
import 'package:tinderapp/src/repository/user_repository.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getUser() async {
    UserResponse response = await _repository.getUser();
    _subject.sink.add(response);
  }

  addUser(User people) {
    print("ADD");
    _repository.getByEmail(people.email).then((user) {
      if (user != people && user == null) {
        _repository.createUser(people).then((people) {});
      }
    }).catchError((e) {
      print(e);
    });
  }

  getByEmail() {}

  setUser(data) {
    _subject.sink.add(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final userBloc = UserBloc();
