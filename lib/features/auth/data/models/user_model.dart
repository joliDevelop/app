// es la representación estructurada de tu domin 

class UserModel {
  final String id;
  final String nombre;
  final String apellidop;
  final String apellidom;
  final int edad;
  final String email;
  final String lada;
  final String telefono;

  UserModel({
    required this.id,
    required this.nombre,
    required this.apellidop,
    required this.apellidom,
    required this.edad,
    required this.email,
    required this.lada,
    required this.telefono,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final edadRaw = json['edad'];
    final edadValue = edadRaw is int
        ? edadRaw
        : int.tryParse(edadRaw?.toString() ?? '') ?? 0;

    return UserModel(
      id: (json['_id'] ?? '').toString(),
      nombre: (json['nombre'] ?? '').toString(),
      apellidop: (json['apellidop'] ?? '').toString(),
      apellidom: (json['apellidom'] ?? '').toString(),
      edad: edadValue,
      email: (json['email'] ?? '').toString(),
      lada: (json['lada'] ?? '').toString(),
      telefono: (json['telefono'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'apellidop': apellidop,
      'apellidom': apellidom,
      'edad': edad,
      'email': email,
      'lada': lada,
      'telefono': telefono,
    };
  }
}
