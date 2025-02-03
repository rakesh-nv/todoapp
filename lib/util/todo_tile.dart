import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Slidable(
        endActionPane: ActionPane(
          motion:StretchMotion(),
          children:[
            SlidableAction(onPressed: deleteFunction,
            icon: Icons.delete,backgroundColor: Colors.red,)
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // check box
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                  ),
                  // task name
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(taskName,
                        style: TextStyle(
                            fontSize: 20,
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
