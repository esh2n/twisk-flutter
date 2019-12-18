// import 'package:flutter/material.dart';
// import 'package:todoey_flutter/widgets/tasks.dart';
// import 'package:todoey_flutter/colors.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:todoey_flutter/screens/add_task_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:todoey_flutter/models/task_data.dart';

// import 'package:todoey_flutter/models/task.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:todoey_flutter/util/database_helper.dart';
// import 'dart:async';

// class LongPeriodTasksScreen extends StatefulWidget {
//   @override
//   _LongPeriodTasksScreenState createState() => _LongPeriodTasksScreenState();
// }

// class _LongPeriodTasksScreenState extends State<LongPeriodTasksScreen> {
//   DatabaseHelper databaseHelper = DatabaseHelper();
//   List<Task> taskList;
//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     if (taskList == null) {
//       taskList = List<Task>();
//       updateListView();
//     }
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isModalOpen = false;
//     return Scaffold(
// //      appBar: AppBar(
// //
// //      ),
//       backgroundColor: mainColor,
//       body: FabCircularMenu(
//         fabColor: addButtonColor,
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(
//                     top: 45.0, left: 30.0, right: 30.0, bottom: 30.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(48.0),
//                           boxShadow: [
//                             new BoxShadow(
//                                 color: Colors.black12, blurRadius: 20.0)
//                           ]),
//                       child: CircleAvatar(
//                         child: Icon(
//                           Icons.list,
//                           size: 30.0,
//                           color: textColor,
//                         ),
//                         backgroundColor: Colors.white,
//                         radius: 30.0,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     Text(
//                       'Twisk',
//                       style: TextStyle(
//                         color: textColor,
//                         fontSize: 50.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       // '${Provider.of<TaskData>(context).taskCount} Tasks', // ! どっちか
//                       '${taskList.length} Tasks',
//                       style: TextStyle(
//                         color: textColor,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.0),
//                           topRight: Radius.circular(20.0)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: shadowColor,
//                           offset: Offset(2, -2),
//                         )
//                       ]),
//                   // child: TasksList(), // ! どっちか
//                   child: getTaskListView(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ringColor: transparentColor,
//         ringDiameter: screenWidth * 0.77,
//         options: <Widget>[
//           IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (context) => AddTaskScreen('ADD', Task(name: '', description: '', date: '')));
//               },
//               iconSize: 48.0,
//               color: addButtonColor),
//           IconButton(
//               icon: Icon(Icons.calendar_today),
//               onPressed: () {},
//               iconSize: 48.0,
//               color: addButtonColor),
//           IconButton(
//               icon: Icon(Icons.date_range),
//               onPressed: () {},
//               iconSize: 48.0,
//               color: addButtonColor),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           title: Text('Home'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.business),
//           title: Text('Business'),
//         ),
//         ],
//       ),
//       drawer: Drawer(),
//     );
//   }

//   ListView getTaskListView() {
//     return ListView.builder(
//       itemCount: count,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           color: Colors.white,
//           elevation: 2.0,
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.amber,
//               child: Text(getFirstLetter(this.taskList[index].name),
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             title: Text(this.taskList[index].name,
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             // subtitle: Text(this.taskList[index].description),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 GestureDetector(
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                   ),
//                   onTap: () {
//                     _delete(context, taskList[index]);
//                   },
//                 ),
//               ],
//             ),
//             onTap: () {
//               debugPrint("ListTile Tapped");
//               // navigateToDetail(this.taskList[index], 'Edit Todo');
//             },
//           ),
//         );
//       },
//     );
//   }

//   getFirstLetter(String title) {
//     return title.substring(0, 2);
//   }

//   void _delete(BuildContext context, Task todo) async {
//     int result = await databaseHelper.deleteTask(todo.id);
//     if (result != 0) {
//       _showSnackBar(context, 'Todo Deleted Successfully');
//       updateListView();
//     }
//   }

//   void _showSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     Scaffold.of(context).showSnackBar(snackBar);
//   }

//   // void navigateToDetail(Task todo, String title) async {
//   //   bool result =
//   //       await Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //     return TodoDetail(todo, title);
//   //   }));

//   //   if (result == true) {
//   //     updateListView();
//   //   }
//   // }

//   void updateListView() {
//     final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//     dbFuture.then((database) {
//       Future<List<Task>> todoListFuture = databaseHelper.getTaskList();
//       todoListFuture.then((todoList) {
//         setState(() {
//           this.taskList = todoList;
//           this.count = todoList.length;
//         });
//       });
//     });
//   }
// }
