import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart'; // Ruta corregida

// Proveedor que maneja la lista de tareas
final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

// Notifier que maneja el estado de la lista de tareas
class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeTask(Task task) {
    state = state.where((t) => t != task).toList();
  }

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i]
    ];
  }

  void removeCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
  }
}
