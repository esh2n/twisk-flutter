import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'package:twisk/models/task.dart';
import 'package:provider/provider.dart';
import 'package:twisk/models/task_data.dart';
import 'package:intl/intl.dart';
import 'package:twisk/util/database_helper.dart';
import 'package:twisk/screens/tasks_screen.dart';

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

  _AddTaskScreenState(this.appBarTitle, this.task);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = task.name;
    descriptionController.text = task.description;

    double containerHeight = MediaQuery.of(context).size.height;

    return Container(
      height: containerHeight * .85,
      color: getAddScreenColor(),
      child: Container(
        padding:
            EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
        decoration: BoxDecoration(
            color: getListBackGroundColor(),
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
                color: getAddButtonColor(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                autofocus: true,
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Title Text Field');
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: getFocusedBorderColor(),
                    ),
                  ),
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
                        color: getAddButtonTextColor(),
                      ),
                    ),
                    color: getAddButtonColor(),
                    onPressed: () {
                      _save();
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
    if (this.appBarTitle == 'Edit Task') {
      return Expanded(
        child: FlatButton(
          child: Text(
            'Delete',
            style: TextStyle(
              color: getAddButtonTextColor(),
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

  // Update the description of todo object
  void updateDescription() {
    task.description = descriptionController.text;
  }

  void _save() async {
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
      // Success
    } else {
      // Failure
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

  Color getListBackGroundColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
    }
  }

  Color getAddScreenColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return addScreenColorDark;
    } else {
      return addScreenColor;
    }
  }

  Color getAddButtonTextColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
    }
  }

  Color getAddButtonColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return textColorDark;
    } else {
      return addButtonColor;
    }
  }

  Color getFocusedBorderColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return Colors.white;
    } else {
      return mainColor;
    }
  }
}
