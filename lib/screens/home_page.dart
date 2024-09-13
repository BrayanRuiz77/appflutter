import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../screens/task_details_page.dart'; // Ruta corregida
import '../screens/add_task_page.dart';    // Ruta corregida



class HomePage extends ConsumerWidget { // Cambia `StatelessWidget` a `ConsumerWidget`
  @override
  Widget build(BuildContext context, WidgetRef ref) { // Asegúrate de usar `WidgetRef` en lugar de `BuildContext`
    final taskList = ref.watch(taskListProvider); // Accede al estado usando Riverpod

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ref.read(taskListProvider.notifier).removeCompletedTasks(); // Usando Riverpod para eliminar tareas
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                ref.read(taskListProvider.notifier).toggleTaskCompletion(index); // Usando Riverpod para cambiar estado
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsPage(task: task),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
