import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';

// Define el Provider
final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
    (StateNotifierProviderRef<TaskListNotifier, List<Task>> ref) =>
        TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super(<Task>[]);

  // Agrega una nueva tarea
  void addTask(Task task) {
    state = <Task>[...state, task]; // Agrega la nueva tarea a la lista
  }

  // Cambia el estado de completado de una tarea
  void toggleTaskCompletion(int index) {
    final List<Task> updatedTasks = [...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks; // Actualiza el estado con la lista actualizada
  }

  // Elimina una tarea de la lista
  void deleteTask(int index) {
    final List<Task> updatedTasks = [...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
  }

  // Actualiza una tarea en la lista
  void updateTask(Task oldTask, Task newTask) {
    final int taskIndex = state.indexWhere((Task task) => task == oldTask);
    if (taskIndex != -1) {
      final List<Task> updatedTasks = [...state];
      updatedTasks[taskIndex] = newTask;
      state = updatedTasks;
    }
  }
}
