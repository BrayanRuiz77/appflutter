import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // No necesitas agregar otra función main aquí!
  runApp(const ProviderScope(
      child: MyApp())); // Asegúrate que esto esté en tu main.dart
}
