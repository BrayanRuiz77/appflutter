import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/models/task.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
  (ref) => TaskListNotifier(),
);

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void removeCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
  }

  void toggleTaskCompletion(int index) {
    state[index] = state[index].copyWith(isCompleted: !state[index].isCompleted);
  }
}

extension TaskExt on Task {
  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description, 
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}