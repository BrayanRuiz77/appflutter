import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
// ignore: library_prefixes
import 'providers/task_provider.dart' as taskProvider;
import 'widgets/add_task_dialog.dart';
import 'widgets/task_details_page.dart';
import 'widgets/settings_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> taskList = ref.watch(taskProvider.taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tareas',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const AddTaskDialog(),
              );
            },
            icon: const Icon(Ionicons.add_outline, size: 30),
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(taskProvider.taskListProvider.notifier)
                  .clearAllCompletedTasks();
            },
            icon: const Icon(Ionicons.trash_outline, size: 30),
          ),
        ],
      ),
      body: taskList.isEmpty
          ? Center(
              child: Text('No hay tareas, agrega una nueva.', style: Theme.of(context).textTheme.titleMedium),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                final Task task = taskList[index];

                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
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
                      fontWeight: FontWeight.bold, 
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
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            // ignore: always_specify_types
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TaskDetailsPage(task: task),
                            ),
                          );
                        },
                        icon: Icon(
                          Ionicons.chevron_forward_outline,
                          size: 24,
                          color: Colors.grey[700], 
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
                              : Ionicons.add_circle,
                          size: 24,
                          color: task.isCompleted ? Colors.green : Colors.grey, 
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(taskProvider.taskListProvider.notifier)
                              .deleteTask(index);
                        },
                        icon: const Icon(
                          Ionicons.trash_outline,
                          size: 24,
                          color: Colors.red, 
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
            builder: (BuildContext context) => const AddTaskDialog(),
          );
        },
        tooltip: 'Agregar tarea',
        child: const Icon(Ionicons.add_outline, size: 30),
      ),
      backgroundColor: Colors.grey[200],
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
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              // ignore: always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => const SettingsPage(),
              ),
            );
          }
        },
      ),
    );
  }
}