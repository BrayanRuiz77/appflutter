import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart'; // Asegúrate de que el archivo models/task.dart esté correctamente implementado
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/task_provider.dart'; // Asegúrate de que el archivo providers/task_provider.dart esté correctamente implementado
import 'widgets/add_task_dialog.dart'; // Asegúrate de que el archivo widgets/add_task_dialog.dart esté correctamente implementado

// Pantalla de detalles de la tarea (opcional)
class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Puedes agregar más detalles de la tarea aquí
            Text('Descripción: ${task.description}'),
            SizedBox(height: 20),
            // Botón para volver a la HomePage
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

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
            builder: (context) => AddTaskDialog(), // Ahora llama correctamente a la clase
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar tarea',
      ),
    );
  }
}

// Asegúrate de que el archivo widgets/add_task_dialog.dart esté correctamente implementado
class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController(); // Agrega el controlador para la descripción

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar nueva tarea'),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del diálogo
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Nombre de la tarea'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descripción'),
          ), // Agrega el campo de texto para la descripción
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                final task = Task(
                  title: _titleController.text,
                  description: _descriptionController.text, // Obtén la descripción del controlador
                );
                ref.read(taskListProvider.notifier).addTask(task);
                Navigator.pop(context);
              }
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}