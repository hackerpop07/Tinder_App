import 'package:tinderapp/src/model/location.dart';
import 'package:tinderapp/src/model/name.dart';

class User {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final String picture;
  final String phone;
  final String password;
  final String SSN;
  final String cell;

  User(this.gender, this.name, this.location, this.picture, this.email,
      this.phone, this.password, this.SSN, this.cell);

  User.fromJson(Map<String, dynamic> json)
      : gender = json["gender"],
        name = Name.fromJson(json["name"]),
        location = Location.fromJson(json["location"]),
        email = json["email"],
        phone = json["phone"],
        picture = json["picture"],
        password = json["password"],
        SSN = json["SSN"],
        cell = json["cell"];
}
