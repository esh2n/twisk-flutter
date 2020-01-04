import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:twisk/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:twisk/util/database_helper.dart';
import 'dart:async';

class UserData extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  // List<User> userList = List<User>();
  List<User> userList;

  UnmodifiableListView<User> get users {
    return UnmodifiableListView(userList);
  }

  int get userListCount {
    if (this.userList != null) {
      return userList.length;
    }
    return 0;
  }

  void updateUserList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async {
      Future<List<User>> userListFuture = databaseHelper.getUserList();
      await userListFuture.then((userList) {
        this.userList = userList;
        notifyListeners();
      });
    });
  }

  void delete(BuildContext context, User user) async {
    int result = await databaseHelper.deleteUserData();
    if (result != 0) {
      updateUserList();
    }
  }

  void initializeData() {
    if (this.userList == null) {
      this.updateUserList();
    }
  }
}
