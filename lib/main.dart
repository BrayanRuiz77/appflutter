import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    final theme = context.read(themeProvider);

    return MaterialApp(
      themeMode: theme,
      title: 'Lista de Tareas',
      theme: ThemeData(
     
        primaryColor: Colors.purple[800], 
        scaffoldBackgroundColor: Colors.grey[200], 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 180, 77, 245), 
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple[800], 
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
        primaryColor: Colors.purple[400], 
        scaffoldBackgroundColor: Colors.grey[800], 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 239, 233, 240), 
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texto blanco en el AppBar
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple[400], 
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