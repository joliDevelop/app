class RegisterUser {
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final int edad;
  final String telefono;
  final String email;
  final String lada;

  RegisterUser({
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.edad,
    required this.telefono,
    required this.email,
    this.lada = "+52",
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "apellidoP": apellidoP,
      "apellidoM": apellidoM,
      "edad": edad,
      "telefono": telefono,
      "email": email,
      "lada": lada,
    };
  }

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      nombre: json["nombre"],
      apellidoP: json["apellidoP"],
      apellidoM: json["apellidoM"],
      edad: json["edad"],
      telefono: json["telefono"],
      email: json["email"],
      lada: json["lada"] ?? "+52",
    );
  }
}