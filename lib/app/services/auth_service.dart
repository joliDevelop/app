import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Error al iniciar sesión');
    }

    return data;
  }

  static Future<Map<String, dynamic>> register({
    required String nombre,
    required String apellidoP,
    required String apellidoM,
    required int edad,
    required String numesocial,
    required String email,
    required String password,
    required String confirmPassword,
    required String lada,
    required String telefono,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombre": nombre,
        "apellidoP": apellidoP,
        "apellidoM": apellidoM,
        "edad": edad,
        "numesocial": numesocial,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "lada": lada,
        "telefono": telefono,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Error al registrar usuario');
    }

    return data;
  }
}
