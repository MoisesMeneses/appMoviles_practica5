import 'package:flutter/material.dart';

class CasillaTablero extends StatelessWidget {
  final String valor; // "X", "O" o vacío
  final VoidCallback alPresionar; // Acción al presionar la casilla

  const CasillaTablero({
    required this.valor,
    required this.alPresionar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: alPresionar, // Llama a la función al hacer tap
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 173, 255, 228),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue, width: 2.0),
        ),
        child: Center(
          child: Text(
            valor,  // Muestra el valor ("X" o "O")
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: valor == 'X' ? Colors.red : Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
