import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart'; // Importa tu modelo de Task


// Proveedor que maneja la lista de tareas
final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

// Notifier que maneja el estado de la lista de tareas
class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(String title) {
    // Crea una nueva tarea y la agrega a la lista de tareas
    state = [...state, Task(title: title)];
  }

  void removeTask(Task task) {
    // Elimina una tarea de la lista
    state = state.where((t) => t != task).toList();
  }
}
