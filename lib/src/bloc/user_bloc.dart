
import 'package:rxdart/rxdart.dart';
import 'package:tinderapp/src/model/user_response.dart';
import 'package:tinderapp/src/repository/user_repository.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject =
  BehaviorSubject<UserResponse>();

  getUser() async {
    UserResponse response = await _repository.getUser();
    _subject.sink.add(response);
    var currentValue = await _subject.first;
    print(currentValue.results[0].phone);
  }

  setUser(data) {
    _subject.sink.add(data);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final userBloc = UserBloc();
