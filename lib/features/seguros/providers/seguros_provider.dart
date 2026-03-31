import 'package:flutter/material.dart';
import '../models/seguro_model.dart';

class SegurosProvider with ChangeNotifier {
  final List<SeguroModel> _catalogo = [
    // GASTOS MÉDICOS MAYORES
    SeguroModel(
      id: '1',
      nombre: 'Gastos Médicos Mayores Esencial',
      descripcion: 'Atención médica sin preocupaciones ante imprevistos.',
      tipo: TipoSeguro.gastosMedicosMayores,
      precioMensual: 450.0,
      beneficios: [
        'Hospitalización ilimitada',
        'Urgencias 24/7',
        'Medicamentos incluidos',
      ],
    ),
    SeguroModel(
      id: '2',
      nombre: 'Gastos Médicos Mayores Premium',
      descripcion: 'Red amplia de hospitales y especialistas.',
      tipo: TipoSeguro.gastosMedicosMayores,
      precioMensual: 950.0,
      beneficios: [
        'Todo lo del plan esencial',
        'Especialistas sin referencia',
        'Cobertura internacional',
      ],
    ),

    // VIDA
    SeguroModel(
      id: '3',
      nombre: 'Seguro de Vida Básico',
      descripcion: 'Protección esencial para ti y tu familia.',
      tipo: TipoSeguro.vida,
      precioMensual: 299.0,
      beneficios: [
        'Cobertura por fallecimiento',
        'Auxilio por accidente',
        'Beneficiarios ilimitados',
      ],
    ),
    SeguroModel(
      id: '4',
      nombre: 'Seguro de Vida Plus',
      descripcion: 'Cobertura ampliada con invalidez total.',
      tipo: TipoSeguro.vida,
      precioMensual: 599.0,
      beneficios: [
        'Todo lo del plan básico',
        'Cobertura por invalidez',
        'Adelanto por enfermedad terminal',
      ],
    ),

    // DAÑOS
    SeguroModel(
      id: '5',
      nombre: 'Seguro de Daños',
      descripcion: 'Protege tu patrimonio ante siniestros.',
      tipo: TipoSeguro.danos,
      precioMensual: 380.0,
      beneficios: [
        'Cobertura por incendio',
        'Robo con violencia',
        'Daños por fenómenos naturales',
      ],
    ),

    // VIAJE
    SeguroModel(
      id: '6',
      nombre: 'Seguro de Viaje',
      descripcion: 'Viaja tranquilo a cualquier parte del mundo.',
      tipo: TipoSeguro.viaje,
      precioMensual: 180.0,
      beneficios: [
        'Asistencia médica en el extranjero',
        'Cancelación de vuelo',
        'Pérdida de equipaje',
      ],
    ),

    // AUTO Y FLOTILLA
    SeguroModel(
      id: '7',
      nombre: 'Seguro de Auto',
      descripcion: 'Cobertura completa para tu vehículo.',
      tipo: TipoSeguro.autoYFlotilla,
      precioMensual: 320.0,
      beneficios: [
        'Daños materiales',
        'Robo total',
        'Responsabilidad civil',
      ],
    ),
    SeguroModel(
      id: '8',
      nombre: 'Seguro de Flotilla',
      descripcion: 'Protege toda tu flota vehicular.',
      tipo: TipoSeguro.autoYFlotilla,
      precioMensual: 850.0,
      beneficios: [
        'Cobertura multi-vehículo',
        'Gestor de siniestros dedicado',
        'Asistencia vial 24/7',
      ],
    ),
  ];

  List<SeguroModel> get catalogo => List.unmodifiable(_catalogo);

  List<SeguroModel> get misSeguros =>
      _catalogo.where((seguro) => seguro.contratado).toList();

  List<SeguroModel> porTipo(TipoSeguro tipo) =>
      _catalogo.where((seguro) => seguro.tipo == tipo).toList();

  void toggleContratado(String id) {
    final index = _catalogo.indexWhere((seguro) => seguro.id == id);

    if (index == -1) return;

    _catalogo[index].contratado = !_catalogo[index].contratado;
    notifyListeners();
  }

  double calcularAnual(double mensual) => mensual * 12;

  double calcularConDescuento(double mensual) => mensual * 12 * 0.9;
}