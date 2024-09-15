import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController(); 

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar nueva tarea'),
      content: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Nombre de la tarea'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
          ),
          const SizedBox(height: 20),
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
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}