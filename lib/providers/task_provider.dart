import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final StateNotifierProvider<TaskListNotifier, List<Task>> taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>(
        (StateNotifierProviderRef<TaskListNotifier, List<Task>> ref) =>
            TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super(<Task>[]) {
    _loadTasks(); // Carga las tareas al inicializarse
  }

  // Agrega una nueva tarea
  void addTask(Task task) {
    state = [...state, task]; // Agrega la nueva tarea a la lista
    _saveTasks(); // Guarda las tareas
  }

  // Cambia el estado de completado de una tarea
  void toggleTaskCompletion(int index) {
    final List<Task> updatedTasks = <Task>[...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks; // Actualiza el estado con la lista actualizada
    _saveTasks(); // Guarda las tareas
  }

  // Elimina una tarea de la lista
  void deleteTask(int index) {
    final List<Task> updatedTasks = <Task>[...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
    _saveTasks(); // Guarda las tareas
  }

  // Actualiza una tarea en la lista
  void updateTask(Task oldTask, Task newTask) {
    final int taskIndex = state.indexWhere((Task task) => task == oldTask);
    if (taskIndex != -1) {
      final updatedTasks = [...state];
      updatedTasks[taskIndex] = newTask;
      state = updatedTasks;
    }
    _saveTasks(); // Guarda las tareas
  }

  // Elimina todas las tareas completadas
  void clearAllCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
    _saveTasks(); // Guarda las tareas
  }

  // Carga las tareas del almacenamiento local
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = prefs.getStringList('tasks');
    if (encodedTasks != null) {
      state = encodedTasks
          .map((encodedTask) => Task.fromJson(jsonDecode(encodedTask)))
          .toList();
    }
  }

  // Guarda las tareas en el almacenamiento local
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks =
        state.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList('tasks', encodedTasks);
  }
}
