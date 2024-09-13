import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para persistencia opcional
import 'dart:convert';

// Clase que maneja la lista de tareas
class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    loadTasks();
  }

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void toggleTaskCompletion(int index) {
    final task = state[index];
    task.isCompleted = !task.isCompleted;
    state = [...state];
  }

  void removeCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
  }

  // Persistencia de datos
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> tasksList = jsonDecode(tasksJson);
      state = tasksList.map((json) => Task.fromJson(json)).toList();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(state.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }

  @override
  set state(List<Task> value) {
    super.state = value;
    saveTasks();
  }
}

// Proveedor global de tareas
final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});
