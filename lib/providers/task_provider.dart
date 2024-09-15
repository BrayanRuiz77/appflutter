import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
    (ref) => TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]); // Inicializa la lista de tareas vacía

  // Agrega una nueva tarea
  void addTask(Task task) {
    state = [...state, task]; // Agrega la nueva tarea a la lista
  }

  // Cambia el estado de completado de una tarea
  void toggleTaskCompletion(int index) {
    final updatedTasks = [...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks; // Actualiza el estado con la lista actualizada
  }

  // Elimina una tarea de la lista
  void deleteTask(int index) {
    final updatedTasks = [...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
  }

  void updateTask(Task task, Task updatedTask) {}
}
