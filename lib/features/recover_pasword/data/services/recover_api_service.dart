import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';

class RcoverService {
  static Future<Map<String, dynamic>> recoverPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/recover/recuperar-contrasena'),
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
