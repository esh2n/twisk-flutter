import 'package:flutter/material.dart';
import 'package:twisk/colors.dart';
import 'dart:async';
import 'tasks_screen.dart';
import 'package:twisk/parts/fab_bottom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_oauth/twitter_oauth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      backgroundColor: getMainColor(),
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
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    'Login to Twitter',
                    style: TextStyle(
                      color: getTextColor(),
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                    ),
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
                  ],
                ),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Text(
                    //   appBarTitle,
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 30.0,
                    //     color: getAddButtonColor(),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 15.0),
                      child: TextField(
                        controller: titleController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          // updateTitle();
                        },
                        decoration: InputDecoration(
                          labelText: 'User ID',
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
                      padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
                      child: TextField(
                        controller: descriptionController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint(
                              'Something changed in Description Text Field');
                          // updateDescription();
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                              'Login',
                              style: TextStyle(
                                color: getAddButtonTextColor(),
                              ),
                            ),
                            color: getAddButtonColor(),
                            onPressed: () {
                              // _save();
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
            ),
          ],
        ),
      ),
    );
  }

  Widget getDeleteButton() {
    if (true) {
      return Expanded(
        child: FlatButton(
          child: Text(
            'Logout',
            style: TextStyle(
              color: getAddButtonTextColor(),
            ),
          ),
          color: Colors.redAccent,
          onPressed: () {
            // _delete();
          },
        ),
      );
    } else {
      return Container();
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

  Color getMainColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return mainColorDark;
    } else {
      return mainColor;
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

  Color getListBackGroundColor() {
    var colorMode = MediaQuery.of(context).platformBrightness;
    if (colorMode == Brightness.dark) {
      return listBackGroundColor;
    } else {
      return Colors.white;
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
