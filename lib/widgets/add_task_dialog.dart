import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart'; // Asegúrate de que el archivo models/task.dart esté correctamente implementado
import '../providers/task_provider.dart'; // Asegúrate de que el archivo providers/task_provider.dart esté correctamente implementado

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController(); 

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
        mainAxisSize: MainAxisSize.min, 
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Nombre de la tarea'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descripción'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                final task = Task(
                  title: _titleController.text,
                  description: _descriptionController.text, 
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