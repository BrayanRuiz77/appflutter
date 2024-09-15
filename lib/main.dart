import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
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
