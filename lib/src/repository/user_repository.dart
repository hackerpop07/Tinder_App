import 'package:tinderapp/src/database/database_helper.dart';
import 'package:tinderapp/src/model/user.dart';
import 'package:tinderapp/src/model/user_response.dart';
import 'package:tinderapp/src/repository/user_api_provider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  DatabaseHelper dbHelper;

  UserRepository() {
    dbHelper = new DatabaseHelper();
  }

  Future<UserResponse> getUser() {
    return _apiProvider.getUser();
  }

  Future<User> createUser(User people) async {
    return await dbHelper.addUser(people);
  }

  Future<User> getByEmail(String email) async {
    return await dbHelper.getByEmail(email);
  }

  Future<List<User>> getAllUser() async {
    return await dbHelper.getAllUser();
  }
}
