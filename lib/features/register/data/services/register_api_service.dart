import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';
import '../../data/models/register_user_model.dart';

class RegisterService {
  static Future<Map<String, dynamic>> preregister(RegisterUser user) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/pre-registro'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
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
      }), // se puede cambiar "channel" a "whatsapp" o "sim"
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
}
