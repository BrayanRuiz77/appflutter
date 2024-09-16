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
    final theme = context.read(themeProvider);

    return MaterialApp(
      themeMode: theme,
      title: 'Lista de Tareas',
      theme: ThemeData(
        // Definimos un tema principal claro
        primaryColor: Colors.purple[800], // Color principal morado
        scaffoldBackgroundColor: Colors.grey[200], // Fondo gris claro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 180, 77, 245), // Color del AppBar morado
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texto blanco en el AppBar
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple[800], // Color del botón flotante morado
        ),
        textTheme: const TextTheme( // Estilos de texto
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey, // Subtítulos en gris
          ),
        ),
      ),
      darkTheme: ThemeData( // Definimos un tema oscuro
        primaryColor: Colors.purple[400], // Color principal morado más claro
        scaffoldBackgroundColor: Colors.grey[800], // Fondo gris oscuro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 239, 233, 240), // Color del AppBar morado
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texto blanco en el AppBar
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple[400], // Color del botón flotante morado
        ),
        textTheme: const TextTheme( // Estilos de texto
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.white, // Subtítulos en blanco
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