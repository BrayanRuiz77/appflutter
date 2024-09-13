class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]); // Inicializa con una lista vacía

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
}

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});
