import 'dart:math';

import 'package:flutter/material.dart';

class EstadoJuego with ChangeNotifier {
  List<String> tablero = List.filled(9, ''); // Tablero 3x3 vacío
  bool turnoJugador = true; // `true` para el jugador, `false` para la IA
  bool juegoTerminado = false;
  String ganador = '';

  void habilitarModoContraMaquina(bool habilitar) {
    // Configuración para futuros modos de juego, por ahora no es necesario implementar más aquí.
  }

  void marcarCasilla(int indice) {
    if (tablero[indice] == '' && !juegoTerminado) {
      tablero[indice] = turnoJugador ? 'X' : 'O'; // Turno del jugador o IA
      if (verificarGanador(turnoJugador ? 'X' : 'O')) {
        ganador = turnoJugador ? 'Jugador X' : 'Jugador O';
        juegoTerminado = true;
        notifyListeners();
        return;
      }
      turnoJugador = !turnoJugador; // Cambiar turno
      notifyListeners();
    }
  }

  void jugarIA() {
  if (juegoTerminado) return;

  final random = Random();

  // Probabilidad de cometer un error (porcentaje entre 0 y 100)
  const int probabilidadError = 40; // 40% de no jugar de forma óptima

  // Cometer error: Jugar en una posición aleatoria
  if (random.nextInt(100) < probabilidadError) {
    for (int i = 0; i < tablero.length; i++) {
      if (tablero[i] == '') {
        tablero[i] = 'O';
        if (verificarGanador('O')) {
          ganador = 'IA';
          juegoTerminado = true;
        }
        turnoJugador = true;
        notifyListeners();
        return;
      }
    }
  }

  // Priorizar ganar
  for (int i = 0; i < tablero.length; i++) {
    if (tablero[i] == '') {
      tablero[i] = 'O';
      if (verificarGanador('O')) {
        ganador = 'IA';
        juegoTerminado = true;
        turnoJugador = true;
        notifyListeners();
        return;
      }
      tablero[i] = '';
    }
  }

  // Bloquear al jugador con menor probabilidad
  if (random.nextInt(100) >= probabilidadError) {
    for (int i = 0; i < tablero.length; i++) {
      if (tablero[i] == '') {
        tablero[i] = 'X';
        if (verificarGanador('X')) {
          tablero[i] = 'O'; // Bloquear al jugador
          turnoJugador = true;
          notifyListeners();
          return;
        }
        tablero[i] = '';
      }
    }
  }

  // Elegir una casilla estratégica con menor prioridad
  const prioridades = [4, 0, 2, 6, 8, 1, 3, 5, 7];
  for (var i in prioridades) {
    if (tablero[i] == '') {
      tablero[i] = 'O';
      if (verificarGanador('O')) {
        ganador = 'IA';
        juegoTerminado = true;
      }
      turnoJugador = true;
      notifyListeners();
      return;
    }
  }
  }



  bool verificarGanador(String jugador) {
    const lineasGanadoras = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var linea in lineasGanadoras) {
      if (linea.every((index) => tablero[index] == jugador)) {
        return true;
      }
    }
    return false;
  }

  void reiniciarJuego() {
    tablero = List.filled(9, '');
    turnoJugador = true;
    juegoTerminado = false;
    ganador = '';
    notifyListeners();
  }
}
