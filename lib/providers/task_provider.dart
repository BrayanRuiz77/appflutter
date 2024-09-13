import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    loadTasks();
  }

  void addTask(Task task) {
    state = [...state, task];
    saveTasks();
  }

  void toggleTaskCompletion(int index) {
    state[index].isCompleted = !state[index].isCompleted;
    state = [...state];
    saveTasks();
  }

  void removeCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
    saveTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List tasksJson = json.decode(tasksString);
      state = tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> tasksJson = state.map((task) => task.toJson()).toList();
    prefs.setString('tasks', json.encode(tasksJson));
  }
}
