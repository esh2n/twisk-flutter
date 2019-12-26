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

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TaskData>(context).taskList == null) {
      Provider.of<TaskData>(context).taskList = List<Task>();
      Provider.of<TaskData>(context).updateListView();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Task('', '', ''), 'Add Task');
        },
        backgroundColor: addButtonColor,
        tooltip: selectedIndex == 0 ? 'Add Task' : 'Login Twitter',
        elevation: 2.0,
        child: Icon(
          selectedIndex == 0 ? Icons.add : Icons.accessibility_new,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: selectedIndex == 0 ? 'Add' : 'Login',
        color: Colors.grey,
        selectedColor: addButtonColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          print(index);
          setState(() {
            selectedIndex = index;
            print(selectedIndex);
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.today, text: 'Task'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Login'),
        ],
      ),
      backgroundColor: mainColor,
      body: _buildChild(),
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("sasa"),
              accountEmail: Text("hoge"),
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
              trailing: Icon(Icons.arrow_upward),
            ),
            ListTile(
              title: Text('Weekly Tasks'),
              trailing: Icon(Icons.arrow_upward),
            ),
            ListTile(
              title: Text('Monthly Tasks'),
              trailing: Icon(Icons.arrow_upward),
            ),
            ListTile(
              title: Text('Yearly Tasks'),
              trailing: Icon(Icons.arrow_upward),
            ),
            Divider(),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    if (this.selectedIndex == 1) {
      return Container();
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
          return AddTaskScreen('ADD', Task('', '', ''));
        });
    print(result);
    if (result == true) {
      Provider.of<TaskData>(context).updateListView();
    }
  }
}
