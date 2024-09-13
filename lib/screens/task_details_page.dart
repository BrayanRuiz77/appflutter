import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de la Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarea: ${task.title}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Estado: ${task.isCompleted ? "Completada" : "Pendiente"}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
