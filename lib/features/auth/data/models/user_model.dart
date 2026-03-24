// es la representación estructurada de tu domin 

class UserModel {
  final String id;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final int edad;
  final String email;
  final String lada;
  final String telefono;

  UserModel({
    required this.id,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.edad,
    required this.email,
    required this.lada,
    required this.telefono,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      nombre: json['nombre'],
      apellidoP: json['apellidoP'],
      apellidoM: json['apellidoM'],
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
      'apellidoP': apellidoP,
      'apellidoM': apellidoM,
      'edad': edad,
      'email': email,
      'lada': lada,
      'telefono': telefono,
    };
  }
}