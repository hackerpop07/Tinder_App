import 'dart:convert';
import 'package:tinderapp/src/model/location.dart';
import 'package:tinderapp/src/model/name.dart';

class User {
  int id;
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


  User.fromMapDb(Map<String, dynamic> map)
      : this.gender = map["gender"],
        this.name = Name.fromJson(json.decode(map["name"].toString())),
        this.location =
        Location.fromJson(json.decode(map["location"].toString())),
        this.email = map["email"],
        this.password = map["password"],
        this.phone = map["phone"],
        this.cell = map["cell"],
        this.SSN = map["SSN"],
        this.picture = map["picture"];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["gender"] = gender;
    map["name"] = name.toJsonString();
    map["location"] = location.toJsonString();
    map["email"] = email;
    map["password"] = password;
    map["phone"] = phone;
    map["cell"] = cell;
    map["SSN"] = SSN;
    map["picture"] = picture;
    return map;
  }


}
