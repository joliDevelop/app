import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/api_config.dart';
import '../data/retiro_model.dart';

class RetiroService {
  /// Envía la solicitud del plan de retiro
  static Future<Map<String, dynamic>> enviarSolicitud(
    RetiroSolicitud solicitud,
  ) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.api}/plan-retiro/solicitud'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(solicitud.toJson()),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Error al enviar solicitud');
    }

    return data;
  }

  /// Obtiene el estado actual de la solicitud del usuario
  static Future<RetiroEstado> obtenerEstado(String solicitudId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.api}/plan-retiro/solicitud/$solicitudId'),
      headers: {'Content-Type': 'application/json'},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Error al obtener estado');
    }

    return RetiroEstado.fromJson(data);
  }
}