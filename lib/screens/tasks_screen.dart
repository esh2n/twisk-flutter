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

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  // int selectedIndex = 0;

  void initiarize(BuildContext context) {
    Provider.of<TaskData>(context).initializeData();
    Provider.of<UserData>(context).initializeData();
    Provider.of<ColorData>(context).initializeData(context);
    databaseHelper.database;
  }

  @override
  Widget build(BuildContext context) {
    initiarize(context);
    bool _isDarkMode = isDark(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Task('', '', ''), 'Add Task');
        },
        backgroundColor: getButtonColor(_isDarkMode),
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
        backgroundColor: getListBackGroundColor(_isDarkMode),
        selectedColor: getBottomColor(_isDarkMode),
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          setState(() {
            Provider.of<TaskData>(context).changeSelectedIndex(index);
            if (Provider.of<UserData>(context).userListCount > 0) {
              // postTwitterRequest(
              //     Provider.of<UserData>(context).userList[0].oauthToken,
              //     Provider.of<UserData>(context).userList[0].oauthTokenSecret);
            }
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.today, text: 'Task'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Login'),
        ],
      ),
      backgroundColor: getMainColor(_isDarkMode),
      body: _buildChild(),
      drawer: Drawer(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            color: getListBackGroundColor(_isDarkMode),
          ),
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: getMainColor(_isDarkMode),
                ),
                accountName: FutureBuilder<Widget>(
                  future: getUserName(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data;
                    }
                    return Text(
                      "ログインしてください",
                      style: TextStyle(
                        color: getTextColor(_isDarkMode),
                      ),
                    );
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
                  backgroundColor: getMainColor(_isDarkMode),
                  child: FutureBuilder<Widget>(
                      future: getUserImage(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
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
                  'Daily Tasks  (${Provider.of<TaskData>(context).taskCount})',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: getTextColor(_isDarkMode),
                ),
                onTap: () {
                  Provider.of<TaskData>(context).changeSelectedTask(0);
                  Provider.of<TaskData>(context).changeSelectedIndex(0);
                  Navigator.pop(context, true);
                },
              ),
              ListTile(
                title: Text(
                  'Weekly Tasks  (${Provider.of<TaskData>(context).weeklyTaskCount})',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: getTextColor(_isDarkMode),
                ),
                onTap: () {
                  Provider.of<TaskData>(context).changeSelectedTask(1);
                  Provider.of<TaskData>(context).changeSelectedIndex(0);

                  Navigator.pop(context, true);
                },
              ),
              ListTile(
                title: Text(
                  'Monthly Tasks  (${Provider.of<TaskData>(context).monthlyTaskCount})',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: getTextColor(_isDarkMode),
                ),
                onTap: () {
                  Provider.of<TaskData>(context).changeSelectedTask(2);
                  Provider.of<TaskData>(context).changeSelectedIndex(0);

                  Navigator.pop(context, true);
                },
              ),
              ListTile(
                title: Text(
                  'Yearly Tasks  (${Provider.of<TaskData>(context).yearlyTaskCount})',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: getTextColor(_isDarkMode),
                ),
                onTap: () {
                  Provider.of<TaskData>(context).changeSelectedTask(3);
                  Provider.of<TaskData>(context).changeSelectedIndex(0);

                  Navigator.pop(context, true);
                },
              ),
              Divider(
                color: getDividerColor(_isDarkMode),
              ),
              Expanded(
                child: Container(),
              ),
              Divider(
                color: getDividerColor(_isDarkMode),
              ),
              SwitchListTile(
                title: Text(
                  'Color Mode',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                value: _isDarkMode,
                onChanged: (bool value) {
                  Provider.of<ColorData>(context).updateColor(value);
                },
              ),
              Divider(
                color: getDividerColor(_isDarkMode),
              ),
              ListTile(
                title: Text(
                  'Close',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                trailing: Icon(
                  Icons.close,
                  color: getTextColor(_isDarkMode),
                ),
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
      ),
    );
  }

  Widget _buildChild() {
    if (Provider.of<TaskData>(context).selectedIndex == 1) {
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
    final bool _isDarkMode = isDark(context);
    int count = Provider.of<UserData>(context).userListCount;
    if (count > 0) {
      if (Provider.of<UserData>(context).userList[0].displayName != null) {
        return Text(
          Provider.of<UserData>(context).userList[0].displayName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: getTextColor(_isDarkMode)),
        );
      }
      return Text(
        "ログインしてください",
        style: TextStyle(
          color: getTextColor(_isDarkMode),
        ),
      );
    }
    return Text(
      "ログインしてください",
      style: TextStyle(
        color: getTextColor(_isDarkMode),
      ),
    );
  }

  Future<Widget> getScreenrName() async {
    final bool _isDarkMode = isDark(context);
    int count = Provider.of<UserData>(context).userListCount;
    if (count > 0) {
      if (Provider.of<UserData>(context).userList[0].screenName != null) {
        return Text(
          "@" + Provider.of<UserData>(context).userList[0].screenName,
          style: TextStyle(
            color: getTextColor(_isDarkMode),
          ),
        );
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
}
