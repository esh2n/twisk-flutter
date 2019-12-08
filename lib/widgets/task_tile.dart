import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:todoey_flutter/colors.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey[100],
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.circular(15.0)
      ),
      margin: EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text('This is a task.',style: TextStyle(color: textColor),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.play_circle_outline),
            SizedBox(
              width: 11,
            ),
            Icon(EvaIcons.twitterOutline),
            Checkbox(
              value: false,
            ),
          ],
        ),
      ),
    );
  }
}
