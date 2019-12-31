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

  bool isDarkMode = false;

  void toggleColorMode() {
    isDarkMode = !isDarkMode;
    print(isDarkMode);
    notifyListeners();
  }

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
    return taskList.length;
  }

  int get weeklyTaskCount {
    return weeklyTaskList.length;
  }

  int get monthlyTaskCount {
    return monthlyTaskList.length;
  }

  int get yearlyTaskCount {
    return yearlyTaskList.length;
  }

  // void updateListView(int index) {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     for (var i = 0; i < 4; i++) {
  //       Future<List<Task>> taskListFuture = databaseHelper.getTaskList(i);
  //       taskListFuture.then((taskList) {
  //         if (i == 0) {
  //           this.taskList = taskList;
  //         }
  //         if (i == 1) {
  //           this.weeklyTaskList = taskList;
  //         }
  //         if (i == 2) {
  //           this.monthlyTaskList = taskList;
  //         }
  //         if (i == 3) {
  //           this.yearlyTaskList = taskList;
  //         }
  //       });
  //       notifyListeners();
  //     }
  //   });
  // }

  void updateListView(int index) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList(index);
      taskListFuture.then((taskList) {
        if (index == 0) {
          this.taskList = taskList;
        }
        if (index == 1) {
          this.weeklyTaskList = taskList;
        }
        if (index == 2) {
          this.monthlyTaskList = taskList;
        }
        if (index == 3) {
          this.yearlyTaskList = taskList;
        }
      });
      notifyListeners();
    });
    notifyListeners();
  }

  void delete(BuildContext context, Task task, int index) async {
    int result = await databaseHelper.deleteTask(task.id, index);
    if (result != 0) {
      updateListView(index);
    }
  }
}
