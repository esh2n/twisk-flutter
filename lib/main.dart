import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twisk/models/color_data.dart';
import 'package:twisk/models/user_data.dart';
import 'screens/tasks_screen.dart';
import 'package:twisk/models/task_data.dart';
import 'colors.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskData()),
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => ColorData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'AmericanTypewriter',
          primaryColor: mainColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'AmericanTypewriter',
          primaryColor: mainColorDark,
        ),
      ),
    );
  }
}
