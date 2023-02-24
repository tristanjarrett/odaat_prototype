import 'package:flutter/material.dart';
import '../models/program.dart';
import '../models/task.dart';
import './program_screen.dart';
import '../widgets/program_tile.dart';
import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isEditMode = false;
  List<Program> _programs = [
    Program(
      name: "Getting Ready for School",
      image: "assets/book.png",
      tasks: [
        Task(name: "Brush your teeth", image: "assets/toothbrush.png"),
        Task(name: "Wash your face", image: "assets/wash_face.png"),
        Task(name: "Get dressed", image: "assets/get_dressed.png"),
        Task(name: "Eat breakfast", image: "assets/eat_breakfast.png"),
      ],
    ),
    Program(
      name: "Going to Bed",
      image: "assets/sleeping.png",
      tasks: [
        Task(name: "Brush your teeth", image: "assets/toothbrush.png"),
        Task(name: "Put on your pajamas", image: "assets/pajamas.png"),
        Task(name: "Read a book", image: "assets/book.png"),
        Task(name: "Go to sleep", image: "assets/sleep.png"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Programs"),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(), // Add the drawer here
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double screenWidth = constraints.maxWidth;

          // Use a single column on small screens (mobile) and three columns on larger screens (tablets)
          final int crossAxisCount = screenWidth < 600 ? 1 : screenWidth < 800 ? 2 : 3;

          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: EdgeInsets.all(16),
            childAspectRatio: 2,
            children: _programs.map((program) {
              return ProgramTile(
                program: program,
                isEditMode: _isEditMode,
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Program"),
                        content: Text(
                            "Are you sure you want to delete this program?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Delete"),
                            onPressed: () {
                              setState(() {
                                _programs.remove(program);
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProgramScreen(program: program)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Add program
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
