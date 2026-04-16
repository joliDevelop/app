import 'package:flutter/material.dart';
import '../models/seguro_model.dart';

class SegurosProvider with ChangeNotifier {
  final List<SeguroModel> _catalogo = [
    // GASTOS MÉDICOS MAYORES
    SeguroModel(
      id: '1',
      nombre: 'Gastos Médicos Mayores',
      descripcion:
          'Cobertura médica nacional e internacional con acceso a hospitales de primer nivel y una amplia red de especialistas.',
      tipo: TipoSeguro.gastosMedicosMayores,
      precioMensual: 450.0,
      beneficios: [
        'Cobertura nacional e internacional',
        'Cobertura desde los 0 hasta los 74 años',
        'Hospitales de primer nivel',
        'Más de 12,000 proveedores médicos',
        'Consultas médicas y medicamentos a domicilio',
        'Estudios de laboratorio, tratamientos y red de especialistas',
      ],
    ),

    // VIDA
    SeguroModel(
      id: '3',
      nombre: 'Seguro de Vida y Temporal',
      descripcion:
          'Protección para tu familia con respaldo financiero ante imprevistos.',
      tipo: TipoSeguro.vida,
      precioMensual: 299.0,
      beneficios: [
        'Respaldo económico para tu familia',
        'Cobertura en caso de fallecimiento',
        'Cobertura por invalidez',
        'Protección ante imprevistos',
      ],
    ),

    // DAÑOS
    SeguroModel(
      id: '5',
      nombre: 'Seguro de Daños',
      descripcion:
          'Protección para tu patrimonio, hogar o negocio ante imprevistos, con respaldo financiero en caso de siniestros.',
      tipo: TipoSeguro.danos,
      precioMensual: 380.0,
      beneficios: [
        'Cobertura ante imprevistos',
        'Protección de bienes, inmuebles y activos',
        'Respaldo financiero ante siniestros',
        'Protección para hogar o negocio',
      ],
    ),

    // VIAJE
    SeguroModel(
      id: '6',
      nombre: 'Seguro de Viaje',
      descripcion:
          'Viaja con tranquilidad con respaldo médico y asistencia en todo momento.',
      tipo: TipoSeguro.viaje,
      precioMensual: 180.0,
      beneficios: [
        'Respaldo médico y asistencia ante emergencias',
        'Atención médica en el extranjero',
        'Asistencia y protección durante tu viaje',
        'Cobertura desde el inicio hasta tu regreso',
      ],
    ),

    // AUTO Y FLOTILLA
    SeguroModel(
      id: '7',
      nombre: 'Seguro de Auto y Flotillas',
      descripcion:
          'Trabajamos con aseguradoras sólidas y confiables para brindarte la mejor protección para tu vehículo o flotilla.',
      tipo: TipoSeguro.autoYFlotilla,
      precioMensual: 320.0,
      beneficios: [
        'Aseguradoras aliadas reconocidas',
        'Opciones con Bupa, MAPFRE, Quálitas y Skandia',
        'Cobertura para autos y flotillas',
        'Protección confiable y personalizada',
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
