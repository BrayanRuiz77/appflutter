import 'package:flutter/material.dart';
import 'widgets/add_task_page.dart'; // Asegúrate de que esta ruta sea correcta
import '..providers/task_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskPage()), // Usa AddTaskPage aquí
            );
          },
          child: Text('Add Task'),
        ),
      ),
    );
  }
}
