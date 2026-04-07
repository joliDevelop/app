import 'package:flutter/material.dart';
import '../models/seguro_model.dart';

class SeguroColors {
  static const joliBlue = Color.fromARGB(255, 11, 193, 238);

  static const gradients = <TipoSeguro, List<Color>>{
    TipoSeguro.gastosMedicosMayores: [
      Color(0xFF26A69A), // teal
      joliBlue,
    ],
    TipoSeguro.vida: [
      Color.fromARGB(255, 193, 2, 193), // gris elegante
      joliBlue,
    ],
    TipoSeguro.danos: [
      Color.fromARGB(255, 215, 20, 20), // naranja profundo
      joliBlue,
    ],
    TipoSeguro.viaje: [
      Color.fromARGB(255, 77, 80, 211), // morado moderno
      joliBlue,
    ],
    TipoSeguro.autoYFlotilla: [
      Color.fromARGB(255, 7, 191, 16), // verde sólido
      joliBlue,
    ],
  };
}
