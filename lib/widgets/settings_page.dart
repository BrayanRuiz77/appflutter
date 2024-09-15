import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/notification_provider.dart'; // Importa el Provider de notificaciones
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final notificationEnabled = ref.watch(notificationProvider); // No más "?"
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.purple[800], // Color de fondo del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tema',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return DropdownButton<ThemeMode>(
                  value: themeMode,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).setThemeMode(value!);
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Claro'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Oscuro'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('Sistema'),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              'Idioma',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return DropdownButton<String>(
                  value: 'Español', // Valor inicial del idioma
                  onChanged: (value) {
                    // Aquí debes implementar la lógica para cambiar el idioma
                    // ref.read(languageProvider.notifier).setLanguage(value!); // Ejemplo
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Español',
                      child: Text('Español'),
                    ),
                    DropdownMenuItem(
                      value: 'Inglés',
                      child: Text('Inglés'),
                    ),
                    // Agrega más idiomas según sea necesario
                  ],
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              'Notificaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return Switch(
                  value: notificationEnabled, // Obtiene el valor del Provider
                  onChanged: (value) {
                    ref
                        .read(notificationProvider.notifier)
                        .setNotifications(value); // Actualiza el Provider
                  },
                );
              },
            ),
            // ... Puedes añadir más opciones de configuración aquí
          ],
        ),
      ),
    );
  }
}
