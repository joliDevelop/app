// data/retiro_model.dart

class RetiroSolicitud {
  final String nombre;
  final String apellidop;
  final String apellidom;
  final int edad;
  final String telefono;
  final String email;
  final double ingresoMensual;
  final double ahorroActual;
  final double aporteMensual;
  final int edadRetiroDeseada;

  RetiroSolicitud({
    required this.nombre,
    required this.apellidop,
    required this.apellidom,
    required this.edad,
    required this.telefono,
    required this.email,
    required this.ingresoMensual,
    required this.ahorroActual,
    required this.aporteMensual,
    required this.edadRetiroDeseada,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellidop": apellidop,
      "apellidom": apellidom,
      "edad": edad,
      "telefono": telefono,
      "email": email,
      "ingresoMensual": ingresoMensual,
      "ahorroActual": ahorroActual,
      "aporteMensual": aporteMensual,
      "edadRetiroDeseada": edadRetiroDeseada,
    };
  }

  factory RetiroSolicitud.fromJson(Map<String, dynamic> json) {
    return RetiroSolicitud(
      nombre: json["nombre"],
      apellidop: json["apellidop"],
      apellidom: json["apellidom"],
      edad: json["edad"],
      telefono: json["telefono"],
      email: json["email"],
      ingresoMensual: (json["ingresoMensual"] as num).toDouble(),
      ahorroActual: (json["ahorroActual"] as num).toDouble(),
      aporteMensual: (json["aporteMensual"] as num).toDouble(),
      edadRetiroDeseada: json["edadRetiroDeseada"],
    );
  }
}

class RetiroEstado {
  final String id;
  final String estatus;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime? fechaActualizacion;

  RetiroEstado({
    required this.id,
    required this.estatus,
    required this.descripcion,
    required this.fechaCreacion,
    this.fechaActualizacion,
  });

  factory RetiroEstado.fromJson(Map<String, dynamic> json) {
    return RetiroEstado(
      id: json["id"].toString(),
      estatus: json["estatus"],
      descripcion: json["descripcion"] ?? "",
      fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      fechaActualizacion: json["fechaActualizacion"] != null
          ? DateTime.parse(json["fechaActualizacion"])
          : null,
    );
  }
}