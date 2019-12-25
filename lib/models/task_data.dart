import 'package:flutter/material.dart';
import 'package:twisk/models/task.dart';
import 'dart:collection';

import 'package:sqflite/sqflite.dart';
import 'package:twisk/util/database_helper.dart';
import 'dart:async';

class TaskData extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> taskList;

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(taskList);
  }

  int get taskCount {
    return taskList.length;
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        this.taskList = taskList;
        notifyListeners();
      });
    });
  }

    void delete(BuildContext context, Task task) async {
    int result = await databaseHelper.deleteTask(task.id);
    if (result != 0) {
      updateListView();
    }
  }
}
