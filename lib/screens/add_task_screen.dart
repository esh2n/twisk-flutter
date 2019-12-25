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
    String newTaskTitle;

    return Container(
      height: containerHeight * .85,
      color: addScreenColor,
      child: Container(
        padding:
            EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: addButtonColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
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
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
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
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            // TextField(
            //   autofocus: true,
            //   textAlign: TextAlign.center,
            //   onChanged: (newText) {
            //     newTaskTitle = newText;
            //   },
            // ),
            // TextField(
            //   autofocus: true,
            //   textAlign: TextAlign.center,
            //   onChanged: (newText) {
            //     newTaskTitle = newText;
            //   },
            // ),
            FlatButton(
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: addButtonColor,
              onPressed: () {
                // Provider.of<TaskData>(context).addTask(newTaskTitle);
                _save();
              },
            ),
          ],
        ),
      ),
    );
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
      // Case 1: Update operation
      result = await helper.updateTask(task);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertTask(task);
    }

    if (result != 0) {
      // Success
    } else {
      // Failure
    }
  }

  void _delete() async {
    Navigator.pop(context, true);
    // Case 1: If user is trying to delete the NEW todo i.e. he has come to
    // the detail page by pressing the FAB of todoList page.
    if (task.id == null) {
      return;
    }

    // Case 2: User is trying to delete the old todo that already has a valid ID.
    int result = await helper.deleteTask(task.id);
    if (result != 0) {
    } else {}
  }
}
