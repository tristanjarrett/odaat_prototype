import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/program.dart';

class ProgramTile extends StatelessWidget {
  final Program program;
  final bool isEditMode;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  ProgramTile({
    required this.program,
    required this.isEditMode,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      program.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: AssetImage(program.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isEditMode)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
