import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void toggleTask(int index) {
    state[index] = state[index].copyWith(completed: !state[index].completed);
    state = [...state];
  }

  void removeTask(int index) {
    state = [...state..removeAt(index)];
  }
}