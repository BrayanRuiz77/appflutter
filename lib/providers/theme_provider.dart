import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<ThemeProvider, ThemeMode> themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>(
  (StateNotifierProviderRef<ThemeProvider, ThemeMode> ref) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}
