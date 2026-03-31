class RegisterUser {
  final String nombre;
  final String apellidop;
  final String apellidom;
  final int edad;
  final String telefono;
  final String email;
  final String lada;

  RegisterUser({
    required this.nombre,
    required this.apellidop,
    required this.apellidom,
    required this.edad,
    required this.telefono,
    required this.email,
    this.lada = "+52",
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellidop": apellidop,
      "apellidom": apellidom,
      "edad": edad,
      "telefono": telefono,
      "email": email,
      "lada": lada,
    };
  }

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      nombre: json["nombre"],
      apellidop: json["apellidop"],
      apellidom: json["apellidom"],
      edad: json["edad"],
      telefono: json["telefono"],
      email: json["email"],
      lada: json["lada"] ?? "+52",
    );
  }
}