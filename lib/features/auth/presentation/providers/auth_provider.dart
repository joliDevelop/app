import 'package:flutter/material.dart';
import '../../data/services/auth_api_service.dart'; 
import '../../../../core/providers/sesion_provider.dart';

class AuthProvider with ChangeNotifier {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required SesionProvider sesionProvider,
  }) async {
    notifyListeners();
    debugPrint('🟡 [AUTH] Iniciando login...');
    debugPrint('📤 Email: $email');
    debugPrint('🔒 Password: ${'*' * password.length}');
    try {
      final data = await AuthService.login(
        email: email.trim(),
        password: password,
      ); // Guardar sesión
      await sesionProvider.login(data.user, data.token);
      return {'ok': true, 'data': data};
    } catch (e) {
      return {
        'ok': false,
        'message': e.toString().replaceFirst("Exception: ", ""),
      };
    } finally {
      notifyListeners();
    }
  }
}
