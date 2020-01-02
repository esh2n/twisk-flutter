import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/models/task.dart';
import 'package:twisk/models/user.dart';
import 'package:twisk/util/database_helper.dart';
import 'package:twisk/models/task_data.dart';
import 'package:twisk/screens/add_task_screen.dart';
import 'package:twisk/models/user_data.dart';

class TaskScreenTask extends StatefulWidget {
  @override
  _TaskScreenTaskState createState() => _TaskScreenTaskState();
}

class _TaskScreenTaskState extends State<TaskScreenTask> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 45.0, left: 30.0, right: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48.0),
                      boxShadow: [
                        new BoxShadow(color: Colors.black12, blurRadius: 20.0)
                      ]),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.dehaze,
                            size: 30.0,
                            color: getTextColor(),
                          ),
                          backgroundColor: getButtonColor(),
                          radius: 30.0,
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(right: 30),
                        child: RawMaterialButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                            Provider.of<UserData>(context).updateUserList();
                          },
                          shape: new CircleBorder(),
                          elevation: 0.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Twisk',
                  style: TextStyle(
                    color: getTextColor(),
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${getTaskCount()} Tasks',
                      style: TextStyle(
                        color: getTextColor(),
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '- ${getTaskType()}',
                      style: TextStyle(
                        color: getTextColor(),
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: getListBackGroundColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: Offset(2, 2),
                    )
                  ]),
              margin: EdgeInsets.only(bottom: 10),
              child: getTaskListView(),
            ),
          ),
        ],
      ),
    );
  }

  ListView getTaskListView() {
    return ListView.builder(
      itemCount: getTaskCount(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: bottomBarColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getBackGroundColor(),
              child: Text(
                  getFirstLetter(
                    getTaskName(index),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            title: Text(
              getTaskName(index),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: getListTextColor(),
              ),
            ),
            subtitle: Text(
              getTaskDescription(index),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context, getCurrentTaskList(context, index),
                        Provider.of<TaskData>(context).selectedTask);
                  },
                ),
              ],
            ),
            onLongPress: () {
              navigateToDetail(this.getCurrentTask(index), 'Edit Task');
            },
          ),
        );
      },
    );
  }

  Task getCurrentTask(int index) {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Provider.of<TaskData>(context).taskList[index];
        break;
      case 1:
        return Provider.of<TaskData>(context).weeklyTaskList[index];
        break;
      case 2:
        return Provider.of<TaskData>(context).monthlyTaskList[index];
        break;
      case 3:
        return Provider.of<TaskData>(context).yearlyTaskList[index];
        break;
      default:
        return Provider.of<TaskData>(context).taskList[index];
    }
  }

  void navigateToDetail(Task task, String name) async {
    bool result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AddTaskScreen(name, task);
        });
    if (result == true) {
      Provider.of<TaskData>(context)
          .updateListView(Provider.of<TaskData>(context).selectedTask);
    }
  }

  getFirstLetter(String title) {
    if (title.length < 2) {
      return title.substring(0, 1);
    }
    return title.substring(0, 2);
  }

  Color getBackGroundColor() {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Colors.amber;
        break;
      case 1:
        return Colors.lime;
        break;
      case 2:
        return Colors.deepPurple;
        break;
      case 3:
        return Colors.brown;
        break;
      default:
        return Colors.amber;
    }
  }

  Color getTextColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return textColorDark;
    } else {
      return textColor;
    }
  }

  Color getListTextColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return listBackGroundColor;
    }
  }

  Color getButtonColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return addButtonColorDark;
    } else {
      return Colors.white;
    }
  }

  Color getListBackGroundColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
    }
  }

  void _delete(BuildContext context, Task task, int index) async {
    int result = await databaseHelper.deleteTask(task.id, index);
    if (result != 0) {
      Provider.of<TaskData>(context).updateListView(index);
    }
  }

  String getTaskName(int index) {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Provider.of<TaskData>(context).taskList[index].name;
        break;
      case 1:
        return Provider.of<TaskData>(context).weeklyTaskList[index].name;
        break;
      case 2:
        return Provider.of<TaskData>(context).monthlyTaskList[index].name;
        break;
      case 3:
        return Provider.of<TaskData>(context).yearlyTaskList[index].name;
        break;
      default:
        return Provider.of<TaskData>(context).taskList[index].name;
    }
  }

  String getTaskDescription(int index) {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Provider.of<TaskData>(context).taskList[index].description;
        break;
      case 1:
        return Provider.of<TaskData>(context).weeklyTaskList[index].description;
        break;
      case 2:
        return Provider.of<TaskData>(context)
            .monthlyTaskList[index]
            .description;
        break;
      case 3:
        return Provider.of<TaskData>(context).yearlyTaskList[index].description;
        break;
      default:
        return Provider.of<TaskData>(context).taskList[index].description;
    }
  }

  int getTaskCount() {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Provider.of<TaskData>(context).taskCount;
        break;
      case 1:
        return Provider.of<TaskData>(context).weeklyTaskCount;
        break;
      case 2:
        return Provider.of<TaskData>(context).monthlyTaskCount;
        break;
      case 3:
        return Provider.of<TaskData>(context).yearlyTaskCount;
        break;
      default:
        return Provider.of<TaskData>(context).taskCount;
    }
  }

  String getTaskType() {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return 'Daily Task';
        break;
      case 1:
        return 'Weekly Task';
        break;
      case 2:
        return 'Monthly Task';
        break;
      case 3:
        return 'Yearly Task';
        break;
      default:
        return 'Daily Task';
    }
  }

  Task getCurrentTaskList(BuildContext context, int index) {
    switch (Provider.of<TaskData>(context).selectedTask) {
      case 0:
        return Provider.of<TaskData>(context).taskList[index];
        break;
      case 1:
        return Provider.of<TaskData>(context).weeklyTaskList[index];
        break;
      case 2:
        return Provider.of<TaskData>(context).monthlyTaskList[index];
        break;
      case 3:
        return Provider.of<TaskData>(context).yearlyTaskList[index];
        break;
      default:
        return Provider.of<TaskData>(context).taskList[index];
    }
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  // void updateListView() {
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
  //     taskListFuture.then((taskList) {
  //       setState(() {
  //         this.taskList = taskList;
  //         this.count = taskList.length;
  //       });
  //     });
  //   });
  // }
}
