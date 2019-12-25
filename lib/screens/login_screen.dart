import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'dart:async';
import 'tasks_screen.dart';
import 'package:twisk/parts/fab_bottom_app_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: addButtonColor,
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
        selectedColor: addButtonColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          print(index);
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TasksScreen()),
            );
          }
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.today, text: 'Task'),
          FABBottomAppBarItem(iconData: Icons.account_circle, text: 'Login'),
        ],
      ),
      backgroundColor: mainColor,
      body: Container(
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
                    'sasa',
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
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
