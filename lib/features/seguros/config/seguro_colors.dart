import 'package:flutter/material.dart';
import '../models/seguro_model.dart';
import '../../../../core/theme/app_colors.dart';

class SeguroColors {
  static const joliBlue = AppColors.joli;

  static const gradients = <TipoSeguro, List<Color>>{
    TipoSeguro.gastosMedicosMayores: [
      joliBlue,
      Color(0xFF4FC3F7),
    ],
    TipoSeguro.vida: [
      joliBlue,
      Color(0xFF1E88E5),
    ],
    TipoSeguro.danos: [
      joliBlue,
      Color(0xFF1565C0), 
    ],
    TipoSeguro.viaje: [
      joliBlue,
      Color(0xFF64B5F6),
    ],
    TipoSeguro.autoYFlotilla: [
      joliBlue,
      Color(0xFF0D47A1),
    ],
  };
}