import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

class TaskListPage extends StatelessWidget {
  final List<Task> tasks;

  const TaskListPage({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas para ${tasks.first.dueDate}'),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text('No hay tareas para esta fecha'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      // Actualiza el estado de la tarea
                      // ...
                    },
                  ),
                );
              },
            ),
    );
  }
}
