import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/tasks_screen.dart';
import 'package:todoey_flutter/models/task_data.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return
        // ChangeNotifierProvider(
        //   builder: (context) => TaskData(),
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
      theme: ThemeData(
        // brightness: Brightness.light,
        fontFamily: 'AmericanTypewriter',
        // primarySwatch: Colors.blue
      ),
    );
    // );
  }
}
