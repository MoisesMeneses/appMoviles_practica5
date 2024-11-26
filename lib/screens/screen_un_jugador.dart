import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/estado_juego.dart';
import '../widgets/casilla_tablero.dart';

class ScreenUnJugador extends StatelessWidget {
  const ScreenUnJugador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Juego del Gato - vs IA')),
      body: Consumer<EstadoJuego>(
        builder: (context, estadoJuego, child) {
          // Habilitar modo contra la máquina
          estadoJuego.habilitarModoContraMaquina(true);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Tablero 3x3
                ),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (context, indice) => CasillaTablero(
                  valor: estadoJuego.tablero[indice],
                  alPresionar: () {
                    estadoJuego.marcarCasilla(indice);
                    if (!estadoJuego.turnoJugador) {
                      estadoJuego.jugarIA(); // Mueve la IA después del turno del jugador
                    }
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              if (estadoJuego.juegoTerminado)
                Text(
                  estadoJuego.ganador.isNotEmpty
                      ? 'Ganador: ${estadoJuego.ganador}'
                      : 'Es un empate',
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ElevatedButton(
                onPressed: estadoJuego.reiniciarJuego,
                child: const Text('Reiniciar Juego'),
              ),
            ],
          );
        },
      ),
    );
  }
}
