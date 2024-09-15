import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'providers/task_provider.dart' as taskProvider;

// Proveedor de la lista de tareas

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
    (ref) => TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    _loadTasks(); // Cargar las tareas al inicializar
  }

  // Agregar una nueva tarea
  void addTask(Task task) {
    state = [...state, task]; // Añadir la nueva tarea a la lista
    _saveTasks(); // Guardar las tareas
  }

  // Cambiar el estado de completado de una tarea
  void toggleTaskCompletion(int index) {
    final updatedTasks = [...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks; // Actualizar el estado
    _saveTasks(); // Guardar las tareas
  }

  // Eliminar una tarea
  void deleteTask(int index) {
    final updatedTasks = [...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
    _saveTasks(); // Guardar las tareas
  }

  // Actualizar una tarea
  void updateTask(Task oldTask, Task newTask) {
    final taskIndex = state.indexWhere((task) => task == oldTask);
    if (taskIndex != -1) {
      final updatedTasks = [...state];
      updatedTasks[taskIndex] = newTask;
      state = updatedTasks;
    }
    _saveTasks(); // Guardar las tareas
  }

  // Eliminar todas las tareas completadas
  void clearAllCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
    _saveTasks(); // Guardar las tareas
  }

  // Cargar tareas desde almacenamiento local
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = prefs.getStringList('tasks');
    if (encodedTasks != null) {
      state = encodedTasks
          .map((encodedTask) => Task.fromJson(jsonDecode(encodedTask)))
          .toList();
    }
  }

  // Guardar tareas en almacenamiento local
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks =
        state.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList('tasks', encodedTasks);
  }
}
