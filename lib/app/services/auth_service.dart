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

  static Future<Map<String, dynamic>> preregister({
    required String nombre,
    required String apellidoP,
    required String apellidoM,
    required int edad,
    required String lada,
    required String telefono,
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/pre-registro'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nombre": nombre,
        "apellidoP": apellidoP,
        "apellidoM": apellidoM,
        "edad": edad,
        "email": email,
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

  static Future<Map<String, dynamic>> sendVerificationCode({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/enviar-codigo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "channel": "email",
      }), // Puedes cambiar "channel" a "whatsapp" o "sms"
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Error al enviar código');
    }

    return data;
  }

  static Future<Map<String, dynamic>> verifyCode({
    required String email,
    required String codigo,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/verificar-codigo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "code": codigo}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Código inválido');
    }

    return data;
  }

  static Future<Map<String, dynamic>> createPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/crear-contrasena'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Error al crear contraseña');
    }

    return data;
  }

  static Future<Map<String, dynamic>> recoverPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/recuperar-contrasena'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Error al recuperar contraseña');
    }

    return data;
  }
}
