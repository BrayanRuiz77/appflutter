import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Título:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(task.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Completada:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
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
