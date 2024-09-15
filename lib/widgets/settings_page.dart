import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.purple[800], // Color de fondo del AppBar
      ),
      body: Center(
        child: Text('Pantalla de Configuración'), // Reemplaza esto con el contenido de la pantalla de Configuración
      ),
    );
  }
}