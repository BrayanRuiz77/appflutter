import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read(themeProvider);

    return MaterialApp(
      themeMode: theme,
      title: 'Lista de Tareas',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 224, 240),
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 30, 195, 245),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromARGB(255, 37, 209, 240),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color.fromARGB(255, 81, 211, 250),
        scaffoldBackgroundColor: Colors.grey[800],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 240, 192, 192),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromARGB(255, 53, 189, 243),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

extension on BuildContext {
  read(StateNotifierProvider<ThemeProvider, ThemeMode> themeProvider) {}
}