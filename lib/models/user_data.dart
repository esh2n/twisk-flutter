import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:twisk/models/task.dart';
import 'dart:collection';
import 'package:twisk/models/user.dart';

import 'package:sqflite/sqflite.dart';
import 'package:twisk/util/database_helper.dart';
import 'dart:async';

class UserData extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<User> userList = List<User>();

  UnmodifiableListView<User> get users {
    return UnmodifiableListView(userList);
  }

  int get userListCount {
    return userList.length;
  }

  void updateUserList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async {
      Future<List<User>> userListFuture = databaseHelper.getUserList();
      await userListFuture.then((userList) {
        this.userList = userList;
      });
      notifyListeners();
    });
    notifyListeners();
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
