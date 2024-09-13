import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import 'add_task_page.dart';
import 'task_details_page.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ref.read(taskListProvider.notifier).removeCompletedTasks();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                ref.read(taskListProvider.notifier).toggleTaskCompletion(index);
              },
            ),
            onTap: () {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
