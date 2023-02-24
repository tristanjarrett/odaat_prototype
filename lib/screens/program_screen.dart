import 'package:flutter/material.dart';
import '../models/program.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class ProgramScreen extends StatefulWidget {
  final Program program;

  ProgramScreen({required this.program});

  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.program.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                isEditMode = !isEditMode;
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenWidth = constraints.maxWidth;

          // Use a single column on small screens (mobile) and three columns on larger screens (tablets)
          final int crossAxisCount = screenWidth < 600 ? 1 : screenWidth < 800 ? 2 : 3;

          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: EdgeInsets.all(16),
            childAspectRatio: 2,
            children: widget.program.tasks.map((task) {
              return TaskTile(
                task: task,
                isEditMode: isEditMode,
                onToggle: (value) {
                  setState(() {
                    task.isComplete = value!;
                  });
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete task?'),
                        content:
                            Text('Are you sure you want to delete this task?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              setState(() {
                                widget.program.tasks.remove(task);
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onEdit: () {
                  if (!isEditMode) {
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController controller =
                          TextEditingController(text: task.name);
                      return AlertDialog(
                        title: Text('Edit task'),
                        content: TextField(controller: controller),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Save'),
                            onPressed: () {
                              String newName = controller.text;
                              Task newTask =
                                  Task(name: newName, image: task.image);
                              int index = widget.program.tasks.indexOf(task);
                              setState(() {
                                widget.program.tasks[index] = newTask;
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: isEditMode
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Add task
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
