import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart'; // Asegúrate de que esta ruta sea correcta
import '../models/task.dart'; // Asegúrate de que esta ruta sea correcta

class AddTaskPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Agregar nueva tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nombre de la tarea'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  // Lee el proveedor y añade la tarea
                  final task = Task(name: _controller.text);
                  ref.read(taskListProvider.notifier).addTask(task);
                  Navigator.pop(context);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

