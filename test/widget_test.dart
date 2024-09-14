import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/providers/task_provider.dart'; // Importar el provider

void main() {
  testWidgets('HomePage muestra un mensaje cuando no hay tareas', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: HomePage())); 

    // Verifica que se muestra el mensaje "No hay tareas"
    expect(find.text('No hay tareas, agrega una nueva.'), findsOneWidget); 
  });

  // Puedes agregar más pruebas para HomePage, como verificar el botón de agregar,
  // la lista de tareas, etc.
}