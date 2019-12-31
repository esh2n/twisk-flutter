import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/screens/add_task_screen.dart';
import 'package:twisk/models/task.dart';
import 'package:twisk/util/database_helper.dart';
import 'login_screen.dart';
import 'package:twisk/screens/task_screen_task.dart';
import 'package:twisk/parts/fab_bottom_app_bar.dart';

import 'package:provider/provider.dart';
import 'package:twisk/models/task_data.dart';

import 'package:twisk/util/twitterLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:twisk/models/user.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<TaskData>(context).isDarkMode;
    // Provider.of<TaskData>(context).updateListView();
    if (Provider.of<TaskData>(context).taskList == null) {
      Provider.of<TaskData>(context).taskList = List<Task>();
      Provider.of<TaskData>(context).updateListView(0);
    }
    if (Provider.of<TaskData>(context).weeklyTaskList == null) {
      Provider.of<TaskData>(context).weeklyTaskList = List<Task>();
      Provider.of<TaskData>(context).updateListView(1);
    }
    if (Provider.of<TaskData>(context).monthlyTaskList == null) {
      Provider.of<TaskData>(context).monthlyTaskList = List<Task>();
      Provider.of<TaskData>(context).updateListView(2);
    }
    if (Provider.of<TaskData>(context).yearlyTaskList == null) {
      Provider.of<TaskData>(context).yearlyTaskList = List<Task>();
      Provider.of<TaskData>(context).updateListView(3);
    }
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
            getUserProfile();
            getDisplayName();
            selectedIndex = index;
            print(selectedIndex);
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
          // padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text("@sasasasa"),
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle,
                  size: 70,
                  color: addButtonColor,
                ),
              ),
              // arrowColor: Colors.white,
            ),
            ListTile(
              title: Text(
                  'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  Provider.of<TaskData>(context).selectedTask = 0;
                });
                print(Provider.of<TaskData>(context).selectedTask);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  // 'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
                  'Weekly Tasks  (${Provider.of<TaskData>(context).weeklyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  Provider.of<TaskData>(context).selectedTask = 1;
                });
                print(Provider.of<TaskData>(context).selectedTask);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  // 'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
                  'Monthly Tasks  (${Provider.of<TaskData>(context).monthlyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  Provider.of<TaskData>(context).selectedTask = 2;
                });
                print(Provider.of<TaskData>(context).selectedTask);
                Navigator.pop(context, true);
              },
            ),
            ListTile(
              title: Text(
                  // 'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})'),
                  'Yearly Tasks  (${Provider.of<TaskData>(context).yearlyTaskCount})'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  Provider.of<TaskData>(context).selectedTask = 3;
                });
                print(Provider.of<TaskData>(context).selectedTask);
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
                Provider.of<TaskData>(context).toggleColorMode();
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
      // return LoginScreen();
      return TwitterOauthPage();
    } else {
      return TaskScreenTask();
    }
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

  void getUserProfile() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    print(user.displayName);
    // if (user) {}
  }

  getDisplayName() {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // FirebaseUser user = await _auth.currentUser();
    // if (user != null) {
    //   String displayName = user.displayName;
    //   return displayName;
    // } else {
    //   return "";
    // }

    // User user;
    // getTwitterRequest();
    // String sasa = user.sample();
    // print(sasa);
  }
}
