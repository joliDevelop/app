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
    return UserModel(
      id: json['_id'],
      nombre: json['nombre'],
      apellidop: json['apellidop'],
      apellidom: json['apellidom'],
      edad: json['edad'],
      email: json['email'],
      lada: json['lada'],
      telefono: json['telefono'],
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