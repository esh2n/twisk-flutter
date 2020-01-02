import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/screens/add_task_screen.dart';
import 'package:twisk/models/task.dart';
import 'package:twisk/util/database_helper.dart';
import 'package:twisk/screens/task_screen_task.dart';
import 'package:twisk/parts/fab_bottom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:twisk/models/task_data.dart';
import 'package:twisk/util/twitterLogin.dart';
import 'package:twisk/models/user_data.dart';
import 'package:twisk/models/color_data.dart';
import 'package:twisk/models/color.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int selectedIndex = 0;

  void initiarize(BuildContext context) {
    Provider.of<TaskData>(context).initializeData();
    Provider.of<UserData>(context).initializeData();
    Provider.of<ColorData>(context).initializeData(context);
    databaseHelper.database;
  }

  bool isDark(BuildContext context) {
    if (Provider.of<ColorData>(context).colorListCount > 0) {
      // Provider.of<ColorData>(context).initializeData(context);
      if (Provider.of<ColorData>(context).colorList[0].colorMode == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      final colorMode = MediaQuery.of(context).platformBrightness;
      if (colorMode == Brightness.light) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = isDark(context);
    initiarize(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Task('', '', ''), 'Add Task');
        },
        backgroundColor: getButtonColor(),
        tooltip: 'Add Task',
        elevation: 2.0,
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Add',
        color: Colors.grey,
        selectedColor: getBottomColor(),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.today, text: 'Task'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Login'),
        ],
      ),
      backgroundColor: getMainColor(),
      body: _buildChild(),
      drawer: Drawer(
        elevation: 10,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<Widget>(
                future: getUserName(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data;
                  }
                  return Text("ログインしてください");
                },
              ),
              accountEmail: FutureBuilder<Widget>(
                  future: getScreenrName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data;
                    }
                    return Text("");
                  }),
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundColor: addButtonColor,
                child: FutureBuilder<Widget>(
                    future: getUserImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      }
                      return ClipOval(
                        child: Icon(
                          Icons.account_circle,
                          size: 70,
                          color: Colors.white,
                        ),
                      );
                    }),
              ),
            ),
            ListTile(
              title: Text(
                  'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Provider.of<TaskData>(context).changeSelectedTask(0);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  // 'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
                  'Weekly Tasks  (${Provider.of<TaskData>(context).weeklyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Provider.of<TaskData>(context).changeSelectedTask(1);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  'Monthly Tasks  (${Provider.of<TaskData>(context).monthlyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Provider.of<TaskData>(context).changeSelectedTask(2);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  'Yearly Tasks  (${Provider.of<TaskData>(context).yearlyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Provider.of<TaskData>(context).changeSelectedTask(3);
                Navigator.pop(context, true);
              },
            ),
            Divider(),
            Expanded(
              child: Container(),
            ),
            Divider(),
            SwitchListTile(
              title: Text('Color Mode'),
              value: _isDarkMode,
              onChanged: (bool value) {
                Provider.of<ColorData>(context).updateColor(value);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
            Container(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    if (this.selectedIndex == 1) {
      return TwitterOauthPage();
    } else {
      return TaskScreenTask();
    }
  }

  Future<Widget> getUserImage() async {
    int count = Provider.of<UserData>(context).userListCount;
    if (count > 0) {
      if (Provider.of<UserData>(context).userList[0].photoURL != null) {
        return ClipOval(
          child: Image.network(
            Provider.of<UserData>(context).userList[0].photoURL,
            height: 70,
            fit: BoxFit.cover,
          ),
        );
      }
    }
    return ClipOval(
      child: Icon(
        Icons.account_circle,
        size: 70,
        color: Colors.white,
      ),
    );
  }

  Future<Widget> getUserName() async {
    int count = Provider.of<UserData>(context).userListCount;
    if (count > 0) {
      if (Provider.of<UserData>(context).userList[0].displayName != null) {
        return Text(
          Provider.of<UserData>(context).userList[0].displayName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        );
      }
      return Text("ログインしてください");
    }
    return Text("ログインしてください");
  }

  Future<Widget> getScreenrName() async {
    int count = Provider.of<UserData>(context).userListCount;
    if (count > 0) {
      if (Provider.of<UserData>(context).userList[0].screenName != null) {
        return Text(
            "@" + Provider.of<UserData>(context).userList[0].screenName);
      }
      return Text("");
    }
    return Text("");
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void navigateToDetail(Task task, String name) async {
    bool result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AddTaskScreen(name, task);
        });
    print(result);
    if (result == true) {
      Provider.of<TaskData>(context)
          .updateListView(Provider.of<TaskData>(context).selectedTask);
    }
  }

  Color getMainColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return mainColorDark;
    } else {
      return mainColor;
    }
  }

  Color getButtonColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return addButtonColorDark;
    } else {
      return addButtonColor;
    }
  }

  Color getBottomColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return bottomBarColor;
    } else {
      return addButtonColor;
    }
  }
}
