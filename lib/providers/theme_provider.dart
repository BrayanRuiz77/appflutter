import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>(
  (ref) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeMode> {
  // Puedes establecer el tema inicial aquí:
  // ThemeMode.system (tema del sistema)
  // ThemeMode.light (tema claro)
  // ThemeMode.dark (tema oscuro)
  ThemeProvider() : super(ThemeMode.system); // Tema inicial: Tema del sistema

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}
