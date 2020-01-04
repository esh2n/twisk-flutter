import 'package:twisk/models/color.dart';
import 'package:twisk/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';
import 'package:twisk/models/user.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String taskTable = 'task_table';
  String weeklyTaskTable = 'weekly_task_table';
  String monthlyTaskTable = 'monthly_task_table';
  String yearlyTaskTable = 'yearly_task_table';
  String colId = 'id';
  String colName = 'name';
  String colDescription = 'description';
  String colDate = 'date';

  String userSettingTable = 'user_setting_table';
  String colDisplayName = 'display_name';
  String colScreenName = 'screen_name';
  String colPhotoURL = 'photo_url';
  String colUserId = 'user_id';
  String colOauthToken = 'oauth_token';
  String colOauthTokenSecret = 'oauth_token_secret';

  String colorTable = 'colorTable';
  String colColorMode = 'color';

  final _lock = new Lock();

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      await _lock.synchronized(() async {
        if (_database == null) {
          _database = await initializeDatabase();
        }
      });
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.toString(), 'twisk.db');
    var tasksDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return tasksDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    print("[Created Tasks Tables]");
    await db.transaction((txn) async {
      await txn.execute(
        'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colDate TEXT)',
      );
      await txn.execute(
        'CREATE TABLE $weeklyTaskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colDate TEXT)',
      );
      await txn.execute(
        'CREATE TABLE $monthlyTaskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colDate TEXT)',
      );
      await txn.execute(
        'CREATE TABLE $yearlyTaskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colDate TEXT)',
      );
      print("[Created UserSetting Table]");
      await txn.execute(
        'CREATE TABLE $userSettingTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDisplayName TEXT, $colScreenName TEXT, $colPhotoURL TEXT, $colUserId TEXT, $colDate TEXT, $colOauthToken TEXT, $colOauthTokenSecret TEXT)',
      );
      print("[Created ColorSetting Table]");
      await txn.execute(
        'CREATE TABLE $colorTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colColorMode INTEGER, $colDate TEXT)',
      );
    });
  }

  Future<List<Map<String, dynamic>>> getColorData() async {
    Database db = await this.database;
    var result = await db.query(colorTable, orderBy: '$colId DESC');
    return result;
  }

  Future<List<ColorSetting>> getColorList() async {
    var colorMapList = await getColorData();
    int count = colorMapList.length;
    List<ColorSetting> colorList = List<ColorSetting>();
    for (int i = 0; i < count; i++) {
      colorList.add(ColorSetting.fromMapObject(colorMapList[i]));
    }
    return colorList;
  }

  Future<List<Map<String, dynamic>>> getUserData() async {
    Database db = await this.database;
    var result = await db.query(userSettingTable, orderBy: '$colId DESC');
    return result;
  }

  Future<List<User>> getUserList() async {
    var userMapList = await getUserData();
    int count = userMapList.length;
    List<User> userList = List<User>();
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> getTaskMapList(int index) async {
    Database db = await this.database;
    switch (index) {
      case 0:
        var result = await db.query(taskTable, orderBy: '$colId DESC');
        return result;
      case 1:
        var result = await db.query(weeklyTaskTable, orderBy: '$colId DESC');
        return result;
      case 2:
        var result = await db.query(monthlyTaskTable, orderBy: '$colId DESC');
        return result;
      case 3:
        var result = await db.query(yearlyTaskTable, orderBy: '$colId DESC');
        return result;
        break;
      default:
        var result = await db.query(taskTable, orderBy: '$colId DESC');
        return result;
    }
  }

  Future<int> insertColorData(ColorSetting color) async {
    Database db = await this.database;
    var result = await db.insert(colorTable, color.toMap());
    return result;
  }

  Future<int> insertUserData(User user) async {
    Database db = await this.database;
    var result = await db.insert(userSettingTable, user.toMap());
    return result;
  }

  Future<int> insertTask(Task task, int index) async {
    Database db = await this.database;
    switch (index) {
      case 0:
        var result = await db.insert(taskTable, task.toMap());
        print("added");
        return result;
        break;
      case 1:
        var result = await db.insert(weeklyTaskTable, task.toMap());
        print("added");
        return result;
        break;
      case 2:
        var result = await db.insert(monthlyTaskTable, task.toMap());
        print("added");
        return result;
        break;
      case 3:
        var result = await db.insert(yearlyTaskTable, task.toMap());
        print("added");
        return result;
        break;
      default:
        var result = await db.insert(taskTable, task.toMap());
        print("added");
        return result;
    }
  }

  Future<int> updateColor(ColorSetting color) async {
    var db = await this.database;
    var result = await db.update(colorTable, color.toMap(),
        where: '$colId = ?', whereArgs: [color.id]);
    return result;
  }

  Future<int> updateTask(Task task, int index) async {
    var db = await this.database;
    switch (index) {
      case 0:
        var result = await db.update(taskTable, task.toMap(),
            where: '$colId = ?', whereArgs: [task.id]);
        return result;
        break;
      case 1:
        var result = await db.update(weeklyTaskTable, task.toMap(),
            where: '$colId = ?', whereArgs: [task.id]);
        return result;
        break;
      case 2:
        var result = await db.update(monthlyTaskTable, task.toMap(),
            where: '$colId = ?', whereArgs: [task.id]);
        return result;
        break;
      case 3:
        var result = await db.update(yearlyTaskTable, task.toMap(),
            where: '$colId = ?', whereArgs: [task.id]);
        return result;
        break;
      default:
        var result = await db.update(taskTable, task.toMap(),
            where: '$colId = ?', whereArgs: [task.id]);
        return result;
    }
  }

  Future<int> updateTaskCompleted(Task task, int index) async {
    var db = await this.database;
    var result = await db.update(taskTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteColorData() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $colorTable');
    return result;
  }

  Future<int> deleteUserData() async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $userSettingTable');
    return result;
  }

  Future<int> deleteTask(int id, int index) async {
    var db = await this.database;
    switch (index) {
      case 0:
        int result =
            await db.rawDelete('DELETE FROM $taskTable WHERE $colId = $id');
        return result;
        break;
      case 1:
        int result = await db
            .rawDelete('DELETE FROM $weeklyTaskTable WHERE $colId = $id');
        return result;
        break;
      case 2:
        int result = await db
            .rawDelete('DELETE FROM $monthlyTaskTable WHERE $colId = $id');
        return result;
        break;
      case 3:
        int result = await db
            .rawDelete('DELETE FROM $yearlyTaskTable WHERE $colId = $id');
        return result;
        break;
      default:
        int result =
            await db.rawDelete('DELETE FROM $taskTable WHERE $colId = $id');
        return result;
    }
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $taskTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Task>> getTaskList(int index) async {
    var taskMapList = await getTaskMapList(index);
    int count = taskMapList.length;
    List<Task> taskList = List<Task>();
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMapObject(taskMapList[i]));
    }
    return taskList;
  }
}
