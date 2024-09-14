import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/task_provider.dart';
import 'package:flutter_application_1/widgets/add_task_dialog.dart';
import 'package:flutter_application_1/widgets/task_details_page.dart';

// ... Resto del código de HomePage

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple[800], // Color de fondo del AppBar
        elevation: 0, // Elimina la sombra del AppBar
      ),
      body: taskList.isEmpty
          ? Center(child: Text('No hay tareas, agrega una nueva.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index]; 

                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,  
                    onChanged: (value) {
                      ref.read(taskListProvider.notifier).toggleTaskCompletion(index);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough  
                          : null,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    task.description, // Agregar la descripción a la lista
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600], 
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsPage(task: task),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
        },
        backgroundColor: Colors.purple[800], // Color del botón flotante
        child: Icon(Icons.add),
        tooltip: 'Agregar tarea',
      ),
      backgroundColor: Colors.grey[200], // Color de fondo de la pantalla
    );
  }
}