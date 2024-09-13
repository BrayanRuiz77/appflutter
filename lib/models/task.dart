class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // Serialización para la persistencia de datos (opcional)
  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(title: json['title'], isCompleted: json['isCompleted']);
  }
}
