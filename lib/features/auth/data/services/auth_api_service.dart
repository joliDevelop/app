import 'dart:convert';
import 'package:http/http.dart' as http;
// peticiones API
import '../../../../core/config/api_config.dart';
// Modelo
import '../models/auth_response_model.dart';

class AuthService {
  static Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthResponseModel.fromJson(data);
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['message'] ?? 'Error en login');
    }
  }
}
