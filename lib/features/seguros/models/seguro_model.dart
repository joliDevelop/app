enum TipoSeguro {
  gastosMedicosMayores,
  vida,
  danos,
  viaje,
  autoYFlotilla,
}

extension TipoSeguroExt on TipoSeguro {
  String get label => switch (this) {
        TipoSeguro.gastosMedicosMayores => 'Gastos Médicos',
        TipoSeguro.vida => 'Vida',
        TipoSeguro.danos => 'Daños',
        TipoSeguro.viaje => 'Viaje',
        TipoSeguro.autoYFlotilla => 'Auto y Flotilla',
      };
}

class SeguroModel {
  final String id;
  final String nombre;
  final String descripcion;
  final TipoSeguro tipo;
  final double precioMensual;
  final List<String> beneficios;
  bool contratado;

  SeguroModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipo,
    required this.precioMensual,
    required this.beneficios,
    this.contratado = false,
  });
}