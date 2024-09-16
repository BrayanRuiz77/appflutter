import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_provider.dart' as taskProvider;

class EditTaskPage extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override

  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends ConsumerState<EditTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _isCompleted = widget.task.isCompleted;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de la tarea'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre para la tarea';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Completada'),
                value: _isCompleted,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isCompleted = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final Task updatedTask = widget.task.copyWith(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isCompleted: _isCompleted,
                    );
                    ref
                        .read(taskProvider.taskListProvider.notifier)
                        .updateTask(widget.task, updatedTask);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}