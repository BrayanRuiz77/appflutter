import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart'
import 'providers/task_provider.dart' as taskProvider;
import 'widgets/add_task_dialog.dart';
import 'widgets/task_details_page.dart'; // Asegúrate de que task_details_page.dart esté definido 
import 'widgets/settings_page.dart'; 

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskProvider.taskListProvider);

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
        backgroundColor: Colors.purple[800],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddTaskDialog(),
              );
            },
            icon: Icon(Ionicons.add_outline, size: 30), // Icono de agregar 
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(taskProvider.taskListProvider.notifier)
                  .clearAllCompletedTasks();
            },
            icon: Icon(Ionicons.trash_outline, size: 30), // Icono de eliminar
          ),
        ],
      ),
      body: taskList.isEmpty
          ? Center(
              child: Text('No hay tareas, agrega una nueva.'),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      ref
                          .read(taskProvider.taskListProvider.notifier)
                          .toggleTaskCompletion(index);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsPage(task: task),
                            ),
                          );
                        },
                        icon: Icon(
                          Ionicons.chevron_forward_outline,
                          size: 24,
                          color: Colors.grey[700],
                        ),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.all(8.0)),
                          elevation: WidgetStateProperty.all(2),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(taskProvider.taskListProvider.notifier)
                              .toggleTaskCompletion(index);
                        },
                        icon: Icon(
                          task.isCompleted
                              ? Ionicons.checkmark_done_circle_outline
                              : Ionicons.circle_outline,
                          size: 24,
                          color: task.isCompleted ? Colors.green : Colors.grey,
                        ),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.all(8.0)),
                          elevation: WidgetStateProperty.all(2),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(taskProvider.taskListProvider.notifier)
                              .deleteTask(index);
                        },
                        icon: Icon(
                          Ionicons.trash_outline,
                          size: 24,
                          color: Colors.red,
                        ),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.all(8.0)),
                          elevation: WidgetStateProperty.all(2),
                        ),
                      ),
                    ],
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
        backgroundColor: Colors.purple[800],
        child: Icon(Ionicons.add_outline, size: 30), // Icono de agregar 
        tooltip: 'Agregar tarea',
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[300],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        onTap: (index) {
          // Manejar el evento al presionar un botón de navegación
          if (index == 1) {
            // Navegar a la pantalla de Configuración
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          }
        },
      ),
    );
  }
}