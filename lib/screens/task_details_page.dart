import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  TaskDetailsPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(task.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Text('Completada:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Checkbox(
              value: task.isCompleted,
              onChanged: null, // Solo para mostrar
            ),
          ],
        ),
      ),
    );
  }
}
