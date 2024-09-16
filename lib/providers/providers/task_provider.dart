import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
    (ref) => TaskListNotifier());

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    _loadTasks();
  }

  void addTask(Task task) {
    state = [...state, task];
    _saveTasks(); 
  }

  void toggleTaskCompletion(int index) {
    final List<Task> updatedTasks = [...state];
    updatedTasks[index] = updatedTasks[index].copyWith(
      isCompleted: !updatedTasks[index].isCompleted,
    );
    state = updatedTasks;
    _saveTasks(); 
  }

  void deleteTask(int index) {
    final updatedTasks = [...state];
    updatedTasks.removeAt(index);
    state = updatedTasks;
    _saveTasks(); 
  }

  void updateTask(Task oldTask, Task newTask) {
    final int taskIndex = state.indexWhere((Task task) => task == oldTask);
    if (taskIndex != -1) {
      final List<Task> updatedTasks = [...state];
      updatedTasks[taskIndex] = newTask;
      state = updatedTasks;
    }
    _saveTasks(); 
  }

  void clearAllCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
    _saveTasks(); 
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = prefs.getStringList('tasks');
    if (encodedTasks != null) {
      state = encodedTasks
          .map((String encodedTask) => Task.fromJson(jsonDecode(encodedTask)))
          .toList();
    }
  }

  Future<void> _saveTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> encodedTasks =
        state.map((Task task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList('tasks', encodedTasks);
  }
}