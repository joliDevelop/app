import 'package:flutter/material.dart';

/// Colores de marca en UN solo lugar.
/// Así no repites Color(0xFF...) por toda la app.
class AppColors {
  // Turquesa principal
  static const Color primary = Color(0xFF18D5E3);
  // Botones/títulos
  static const Color navy = Color.fromARGB(255, 2, 149, 198);

  static const Color joli = Color.fromARGB(255, 11, 193, 238);

  static const Color dark = Color.fromARGB(255, 0, 0, 0);
  // Fondo claro
  static const Color background = Color(0xFFFFFFFF);
  // Texto secundario / gris
  static const Color textMuted = Color(0xFF6B7280);
  // Borde suave
  static const Color border = Color(0xFFE5E7EB);
}
