import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
    (ref) => TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  // Agrega una nueva tarea
  void addTask(Task task) {
    state = [...state, task];
  }

  // Cambia el estado de completado de una tarea
  void toggleTaskCompletion(int index) {
    final updatedTasks = [...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks;
  }

  // Elimina una tarea de la lista
  void deleteTask(int index) {
    final updatedTasks = [...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
  }

  // Actualiza una tarea en la lista
  void updateTask(Task oldTask, Task newTask) {
    final taskIndex = state.indexWhere((task) => task == oldTask);
    if (taskIndex != -1) {
      final updatedTasks = [...state];
      updatedTasks[taskIndex] = newTask;
      state = updatedTasks;
    }
  }
}
