import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/models/task.dart';
import 'package:twisk/util/database_helper.dart';
import 'package:twisk/models/task_data.dart';

class TaskScreenTask extends StatefulWidget {
  @override
  _TaskScreenTaskState createState() => _TaskScreenTaskState();
}

class _TaskScreenTaskState extends State<TaskScreenTask> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count;

  @override
  Widget build(BuildContext context) {
    List<Task> taskList = Provider.of<TaskData>(context).tasks;
    if (taskList == null) {
      taskList = List<Task>();
      Provider.of<TaskData>(context).updateListView();
    }
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
                            Icons.list,
                            size: 30.0,
                            color: textColor,
                          ),
                          backgroundColor: Colors.white,
                          radius: 30.0,
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(right: 30),
                        child: RawMaterialButton(
                          onPressed: () {
                            print("show drawer button tapped");
                            Scaffold.of(context).openDrawer();
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
                    color: textColor,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${Provider.of<TaskData>(context).taskCount} Tasks',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
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
      itemCount: Provider.of<TaskData>(context).taskCount,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: bottomBarColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(
                  getFirstLetter(
                      Provider.of<TaskData>(context).taskList[index].name),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(Provider.of<TaskData>(context).taskList[index].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
                Provider.of<TaskData>(context).taskList[index].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context,
                        Provider.of<TaskData>(context).taskList[index]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              // navigateToDetail(this.taskList[index], 'Edit Todo');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Task task) async {
    int result = await databaseHelper.deleteTask(task.id);
    if (result != 0) {
      Provider.of<TaskData>(context).updateListView();
    }
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  // void navigateToDetail(Task task, String name) async {
  //   bool result = await showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return AddTaskScreen('ADD', Task('', '', ''));
  //       });
  //   print(result);
  //   if (result == true) {
  //     updateListView();
  //   }
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
