// estado global de autenticación
// -| Mantener al usuario en memoria
// -| Guardar / leer datos del storage
// -| Notificar a la UI cuando cambia la sesión

import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SesionProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  String? _token;

  Map<String, dynamic>? get user => _user;
  String? get token => _token;

  bool get isLogged => _user != null && _token != null;

  Future<void> loadSession() async {
    _user = await StorageService.getUser();
    _token = await StorageService.getToken();
    notifyListeners();
  }

  // RECIBE Y ENVIA LOS DATOS PARA GUARDARLOS EN EL STORAGE, Y ACTUALIZA EL ESTADO LOCAL
  Future<void> login(Map<String, dynamic> user, String token) async {
    await StorageService.saveToken(token);
    await StorageService.saveUser(user);

    // Guarda los 2 datos en memoria
    _user = user;
    _token = token;

    notifyListeners();
  }

  Future<void> logout() async {
    await StorageService.clearSession();
    _user = null;
    _token = null;
    notifyListeners();
  }
}
