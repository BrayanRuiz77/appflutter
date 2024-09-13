import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_project_name/screens/home_page.dart'; // Asegúrate de cambiar 'your_project_name'

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),  // Establece HomePage como la pantalla principal
    );
  }
}

