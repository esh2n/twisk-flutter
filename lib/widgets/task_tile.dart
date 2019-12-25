import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:twisk/colors.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkBoxCallback;
  final Function longPressCallBack;

  TaskTile({this.isChecked, this.taskTitle, this.checkBoxCallback, this.longPressCallBack});

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey[100],
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[100]),
          borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        onLongPress: longPressCallBack,
        title: Text(
          taskTitle,
          style: TextStyle(
              color: textColor,
              decoration: isChecked ? TextDecoration.lineThrough : null,
              decorationThickness: 5.85
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.play_circle_outline),
            SizedBox(
              width: 11,
            ),
            Icon(EvaIcons.twitterOutline),
            Checkbox(
              activeColor: addButtonColor,
              value: isChecked,
              onChanged: (newValue) {
                checkBoxCallback(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}





