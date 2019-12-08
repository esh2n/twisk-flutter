import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/tasks.dart';
import 'package:todoey_flutter/colors.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//
//      ),
    backgroundColor: mainColor,
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: addButtonColor,
//        child: Icon(Icons.add, size: 40.0,),
//        onPressed: () {
//        },
//      ),
      body: FabCircularMenu(
        fabColor: addButtonColor,
          child: Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48.0),
                          boxShadow: [new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0
                          )]
                      ),
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
                      '12 Tasks',
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
                        topRight: Radius.circular(20.0)),
                  ),
                  child: TasksList(),
                ),
              ),
            ],
          ),
          ),
          ringColor: Colors.black12,
          options: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {}, iconSize: 48.0, color: addButtonColor),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}, iconSize: 48.0, color: addButtonColor),
            IconButton(icon: Icon(Icons.date_range), onPressed: () {}, iconSize: 48.0, color: addButtonColor),
          ],
      ),
      drawer: Drawer(),
    );
  }
}
