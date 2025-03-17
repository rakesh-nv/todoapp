import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final bool isPriority;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final VoidCallback onEdit;
  final VoidCallback onPriorityToggle;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.isPriority = false,
    required this.onChanged,
    required this.deleteFunction,
    required this.onEdit,
    required this.onPriorityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (_) => onEdit(),
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: SizedBox(
          height: 70,
          child: Card(
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                ),
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                      decoration: taskCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: isPriority ? Colors.amber : Colors.grey,
                  ),
                  onPressed: onPriorityToggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
