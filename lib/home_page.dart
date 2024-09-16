import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'providers/task_provider.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/task_details_page.dart';
import 'widgets/settings_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AddTaskDialog(),
              );
            },
            icon: const Icon(Ionicons.add_outline, size: 30),
          ),
          IconButton(
            onPressed: () {
              ref.read(taskListProvider.notifier).clearAllCompletedTasks();
            },
            icon: const Icon(Ionicons.trash_outline, size: 30),
          ),
        ],
      ),
      body: taskList.isEmpty
          ? Center(
              child: Text(
                'No hay tareas, agrega una nueva.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];

                return Dismissible(
                  key: Key(task.title), 
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Ionicons.trash_outline, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref.read(taskListProvider.notifier).deleteTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tarea eliminada')),
                    );
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        ref.read(taskListProvider.notifier).toggleTaskCompletion(index);
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
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
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsPage(task: task, index: index),
                              ),
                            );
                          },
                          icon: Icon(
                            Ionicons.chevron_forward_outline,
                            size: 25,
                            color: Colors.grey[700],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(taskListProvider.notifier).toggleTaskCompletion(index);
                          },
                          icon: Icon(
                            task.isCompleted
                                ? Ionicons.checkmark_done_circle_outline
                                : Ionicons.add_circle,
                            size: 25,
                            color: task.isCompleted ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(),
          );
        },
        label: const Text('+'),
        icon: const Icon(Ionicons.chatbubble_outline),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 3,
        isExtended: true,
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 46, 171, 243),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
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
        onTap: (index) {
          if (index == 1) {
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