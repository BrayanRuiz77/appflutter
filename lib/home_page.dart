import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/task_provider.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/task_details_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> taskList = ref.watch(taskListProvider); 

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tareas',
          style: TextStyle( 
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[800], // Color de fondo del AppBar
        elevation: 0, // Elimina la sombra del AppBar
      ),
      body: taskList.isEmpty
          ? const Center(child: Text('No hay tareas, agrega una nueva.'))
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                final Task task = taskList[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
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
                    task.description, 
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        // ignore: always_specify_types
                        MaterialPageRoute(
                          builder: (BuildContext context) => TaskDetailsPage(task: task),
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
            builder: (BuildContext context) => const AddTaskDialog(),
          );
        },
        backgroundColor: Colors.purple[800],
        tooltip: 'Agregar tarea', // Color del botón flotante
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[200], // Color de fondo de la pantalla
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[800], 
        selectedItemColor: Colors.white, 
        unselectedItemColor: Colors.grey[300],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}