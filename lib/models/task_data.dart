import 'package:flutter/material.dart';
import 'package:twisk/models/task.dart';
import 'dart:collection';

import 'package:sqflite/sqflite.dart';
import 'package:twisk/util/database_helper.dart';
import 'dart:async';

class TaskData extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> taskList;
  List<Task> weeklyTaskList;
  List<Task> monthlyTaskList;
  List<Task> yearlyTaskList;
  int selectedTask = 0;

  UnmodifiableListView<Task> get tasks {
    switch (this.selectedTask) {
      case 0:
        return UnmodifiableListView(taskList);
        break;
      case 1:
        return UnmodifiableListView(weeklyTaskList);
        break;
      case 2:
        return UnmodifiableListView(monthlyTaskList);
        break;
      case 3:
        return UnmodifiableListView(yearlyTaskList);
        break;
      default:
        return UnmodifiableListView(taskList);
    }
  }

  int get taskCount {
    switch (this.selectedTask) {
      case 0:
        return taskList.length;
        break;
      case 1:
        return weeklyTaskList.length;
        break;
      case 2:
        return monthlyTaskList.length;
        break;
      case 3:
        return yearlyTaskList.length;
        break;
      default:
        return taskList.length;
    }
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
