import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart'; 

void main() {
  runApp(const ProviderScope(child: MyApp())); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        // Define tu tema de color
        primaryColor: Colors.blue,
        hintColor: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: HomePage(),
    );
  }
}