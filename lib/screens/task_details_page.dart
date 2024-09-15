import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart'; // Asegúrate de que Task esté definido en models/task.dart

class TaskDetailsPage extends StatelessWidget {
  final Task task; // Define el parámetro task en el constructor

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title), // Muestra el título de la tarea
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Título: ${task.title}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Descripción: ${task.description}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
