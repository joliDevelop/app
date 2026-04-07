import 'package:flutter/material.dart';
import '../models/seguro_model.dart';
import 'seguro_colors.dart';

class SeguroUIConfig {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final String label;

  const SeguroUIConfig({
    required this.icono,
    required this.titulo,
    required this.subtitulo,
    required this.label,
  });
}

class SeguroUI {
  static const configs = <TipoSeguro, SeguroUIConfig>{
    TipoSeguro.gastosMedicosMayores: SeguroUIConfig(
      icono: Icons.local_hospital_rounded,
      titulo: 'Gastos Médicos Mayores',
      subtitulo: 'Cobertura médica para ti y tu familia',
      label: 'Gastos\nMédicos',
    ),
    TipoSeguro.vida: SeguroUIConfig(
      icono: Icons.favorite_rounded,
      titulo: 'Seguro de Vida',
      subtitulo: 'Protege el futuro de los tuyos',
      label: 'Vida',
    ),
    TipoSeguro.danos: SeguroUIConfig(
      icono: Icons.home_rounded,
      titulo: 'Seguro de Daños',
      subtitulo: 'Protege tu patrimonio ante siniestros',
      label: 'Daños',
    ),
    TipoSeguro.viaje: SeguroUIConfig(
      icono: Icons.flight_rounded,
      titulo: 'Seguro de Viaje',
      subtitulo: 'Viaja tranquilo a cualquier parte del mundo',
      label: 'Viaje',
    ),
    TipoSeguro.autoYFlotilla: SeguroUIConfig(
      icono: Icons.directions_car_rounded,
      titulo: 'Auto y Flotilla',
      subtitulo: 'Cobertura completa para tu vehículo',
      label: 'Auto y\nFlotilla',
    ),
  };

  static List<Color> getGradient(TipoSeguro tipo) {
    return SeguroColors.gradients[tipo]!;
  }
}