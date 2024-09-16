import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/notification_provider.dart';
import 'package:flutter_application_1/providers/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeProvider);
    final bool notificationEnabled = ref.watch(notificationProvider);
    final String selectedLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tema',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return DropdownButton<ThemeMode>(
                  value: themeMode,
                  onChanged: (ThemeMode? value) {
                    ref.read(themeProvider.notifier).setThemeMode(value!);
                  },
                  items: const <DropdownMenuItem<ThemeMode>>[
                   
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
            const SizedBox(height: 32),
            const Text(
              'Idioma',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return DropdownButton<String>(
                  value: selectedLanguage,
                  onChanged: (String? value) {
                    ref.read(languageProvider.notifier).setLanguage(value!);
                  },
                  items: const <DropdownMenuItem<String>>[
                   
                    DropdownMenuItem(
                      value: 'Español',
                      child: Text('Español'),
                    ),
                 
                    DropdownMenuItem(
                      value: 'Inglés',
                      child: Text('Inglés'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Notificaciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Switch(
                  value: notificationEnabled,
                  onChanged: (bool value) {
                    ref
                        .read(notificationProvider.notifier)
                        .setNotifications(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}