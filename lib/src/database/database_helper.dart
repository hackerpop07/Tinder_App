import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tinderapp/src/model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database _db;

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, "database_v1.db");
    var dbConnection =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbConnection;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE users(
      id INTEGER PRIMARY KEY, 
      gender TEXT, 
      name TEXT, 
      location TEXT, 
      email TEXT, 
      password TEXT,
      phone TEXT,
      cell TEXT,
      SSN TEXT,
      picture TEXT
    )''');
  }

  Future<User> addUser(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert("users", user.toMap());
    print(user.id);
    return user;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('users');
    List<User> peoples = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        peoples.add(User.fromMapDb(maps[i]));
      }
    }
    return peoples;
  }

  Future<User> getByEmail(String email) async {
    final dbClient = await db;
    var res =
        await dbClient.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? User.fromMapDb(res.first) : null;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
