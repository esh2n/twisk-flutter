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

  // void toggleColorMode() {
  //   isDarkMode = !isDarkMode;
  //   notifyListeners();
  // }

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

  UnmodifiableListView<Task> get weeklyTasks {
    return UnmodifiableListView(weeklyTaskList);
  }

  UnmodifiableListView<Task> get monthlyTasks {
    return UnmodifiableListView(monthlyTaskList);
  }

  UnmodifiableListView<Task> get yearlyTasks {
    return UnmodifiableListView(yearlyTaskList);
  }

  int get taskCount {
    if (this.taskList != null) {
      return taskList.length;
    }
    return 0;
  }

  int get weeklyTaskCount {
    if (this.weeklyTaskList != null) {
      return weeklyTaskList.length;
    }
    return 0;
  }

  int get monthlyTaskCount {
    if (this.monthlyTaskList != null) {
      return monthlyTaskList.length;
    }
    return 0;
  }

  int get yearlyTaskCount {
    if (this.yearlyTaskList != null) {
      return yearlyTaskList.length;
    }
    return 0;
  }

  void updateListView(int index) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList(index);
      taskListFuture.then((taskList) {
        if (index == 0) {
          this.taskList = taskList;
          notifyListeners();
        }
        if (index == 1) {
          this.weeklyTaskList = taskList;
          notifyListeners();
        }
        if (index == 2) {
          this.monthlyTaskList = taskList;
          notifyListeners();
        }
        if (index == 3) {
          this.yearlyTaskList = taskList;
          notifyListeners();
        }
      });
    });
  }

  void changeSelectedTask(int index) {
    this.selectedTask = index;
    notifyListeners();
  }

  void delete(BuildContext context, Task task, int index) async {
    int result = await databaseHelper.deleteTask(task.id, index);
    if (result != 0) {
      updateListView(index);
    }
  }

  void initializeData() {
    // print(this.taskList);
    if (this.taskList == null) {
      this.updateListView(0);
    }
    if (this.weeklyTaskList == null) {
      this.updateListView(1);
    }
    if (this.monthlyTaskList == null) {
      this.updateListView(2);
    }
    if (this.yearlyTaskList == null) {
      this.updateListView(3);
    }
  }
}
