import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/task_provider.dart'; // Proveedor de tareas
// Pantalla de detalles de la tarea (opcional)

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider); // Obtenemos la lista de tareas del provider

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Eliminar las tareas completadas
              ref.read(taskListProvider.notifier).removeCompletedTasks();
            },
            tooltip: 'Eliminar tareas completadas',
          ),
        ],
      ),
      body: taskList.isEmpty
          ? Center(child: Text('No hay tareas, agrega una nueva.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];

                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      // Cambiar el estado de completado de la tarea
                      ref.read(taskListProvider.notifier).toggleTaskCompletion(index);
                    },
                  ),
                  onTap: () {
                    // Navegar a la pantalla de detalles de la tarea (opcional)
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
          // Mostrar el diálogo para agregar una nueva tarea
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar tarea',
      ),
    );
  }
}

AddTaskDialog() {
}

TaskDetailsPage({required Task task}) {
}
