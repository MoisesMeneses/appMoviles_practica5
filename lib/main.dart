import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/estado_juego.dart';
import 'screens/screen_inicio.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EstadoJuego(),  // Aquí se crea el proveedor para el estado del juego
      child: const JuegoGatoApp(),
    ),
  );
}

class JuegoGatoApp extends StatelessWidget {
  const JuegoGatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego del Gato',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScreenInicio(),
    );
  }
}

