import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final bool isEditMode;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Key? key;

  TaskTile({
    required this.task,
    required this.isEditMode,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: () => isEditMode ? onEdit() : onToggle(!task.isComplete),
      child: Card(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(task.image, fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    task.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            if (task.isComplete)
              Container(
                color: Colors.green.withOpacity(0.8),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 48.0,
                  ),
                ),
              ),
            if (isEditMode)
              Positioned(
                top: 0,
                right: 0,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
