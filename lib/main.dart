import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart';
import 'providers/theme_provider.dart'; // Importa theme_provider.dart

void main() {
  // No necesitas agregar otra función main aquí!
  runApp(
      ProviderScope(child: MyApp())); // Asegúrate que esto esté en tu main.dart
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read(themeProvider);

    return MaterialApp(
      themeMode: theme,
      title: 'Lista de Tareas',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

extension on BuildContext {
  read(StateNotifierProvider<ThemeProvider, ThemeMode> themeProvider) {}
}
