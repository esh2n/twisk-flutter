import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/models/task.dart';
import 'package:provider/provider.dart';
import 'package:twisk/models/task_data.dart';
import 'package:intl/intl.dart';
import 'package:twisk/models/user.dart';
import 'package:twisk/util/database_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:twisk/models/user_data.dart';

class AddTaskScreen extends StatefulWidget {
  final String appBarTitle;
  final Task task;
  AddTaskScreen(this.appBarTitle, this.task);
  @override
  _AddTaskScreenState createState() =>
      _AddTaskScreenState(this.appBarTitle, this.task);
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Task task;
  bool doTweet = false;

  _AddTaskScreenState(this.appBarTitle, this.task);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = task.name;
    descriptionController.text = task.description;
    double containerHeight = MediaQuery.of(context).size.height;
    bool _isDarkMode = isDark(context);
    return Container(
      height: containerHeight * .85,
      color: getAddScreenColor(_isDarkMode),
      child: Container(
        padding:
            EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
        decoration: BoxDecoration(
            color: getListBackGroundColor(_isDarkMode),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              appBarTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: getAddButtonColor(_isDarkMode),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                autofocus: true,
                controller: titleController,
                style: TextStyle(
                  color: getTextColor(_isDarkMode),
                ),
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(_isDarkMode),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(_isDarkMode),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: TextStyle(
                  color: getTextColor(_isDarkMode),
                ),
                onChanged: (value) {
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(_isDarkMode),
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(_isDarkMode),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: SwitchListTile(
                title: Text(
                  'Tweet',
                  style: TextStyle(
                    color: getTextColor(_isDarkMode),
                  ),
                ),
                value: doTweet,
                onChanged: (bool value) {
                  setState(() {
                    this.doTweet = value;
                  });
                },
                secondary: Icon(
                  EvaIcons.twitter,
                  color: getTextColor(_isDarkMode),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: getAddButtonTextColor(_isDarkMode),
                      ),
                    ),
                    color: getAddButtonColor(_isDarkMode),
                    onPressed: () {
                      _save(doTweet);
                    },
                  ),
                ),
                Container(
                  width: 20.0,
                ),
                getDeleteButton()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getDeleteButton() {
    bool _isDarkMode = isDark(context);
    if (this.appBarTitle == 'Edit Task') {
      return Expanded(
        child: FlatButton(
          child: Text(
            'Delete',
            style: TextStyle(
              color: getAddButtonTextColor(_isDarkMode),
            ),
          ),
          color: Colors.redAccent,
          onPressed: () {
            _delete();
          },
        ),
      );
    } else {
      return Container();
    }
  }

  void updateTitle() {
    task.name = titleController.text;
  }

  void updateDescription() {
    task.description = descriptionController.text;
  }

  void _save(bool doTweet) async {
    Navigator.pop(context, true);
    task.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (task.id != null) {
      result = await helper.updateTask(
          task, Provider.of<TaskData>(context).selectedTask);
    } else {
      result = await helper.insertTask(
          task, Provider.of<TaskData>(context).selectedTask);
    }
    if (result != 0) {
      if (Provider.of<UserData>(context).userListCount > 0) {
        if (doTweet) {
          if (task.name.length >= task.description.length) {
            postTweet(task.name);
          } else {
            postTweet(task.description);
          }
        }
      }
      // Success
    } else {
      // Failure
    }
  }

  void postTweet(String sentence) {
    if (Provider.of<UserData>(context).userListCount > 0) {
      postTwitterRequest(
        Provider.of<UserData>(context).userList[0].oauthToken,
        Provider.of<UserData>(context).userList[0].oauthTokenSecret,
        sentence,
      );
    }
  }

  void _delete() async {
    Navigator.pop(context, true);
    if (task.id == null) {
      return;
    }

    int result = await helper.deleteTask(
        task.id, Provider.of<TaskData>(context).selectedTask);
    if (result != 0) {
    } else {}
  }
}
