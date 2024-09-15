import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class Task implements EventInterface {
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dueDate;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
  });

  // Constructor para crear una copia de la tarea con nuevos valores
  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  // Convierte la tarea a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate.toIso8601String(), // Guarda la fecha en formato ISO
    };
  }

  // Crea una tarea a partir de un mapa JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  @override
  String getTitle() => title; // Devuelve el título de la tarea

  @override
  Duration getDuration() =>
      Duration.zero; // Puedes ajustar si necesitas duración
}
