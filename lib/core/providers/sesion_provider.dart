// estado global de autenticación
// -| Mantener al usuario en memoria
// -| Guardar / leer datos del storage
// -| Notificar a la UI cuando cambia la sesión

import 'package:flutter/material.dart';
import '../services/storage_service.dart';
// Modelos del login del user 
import '../../features/auth/data/models/user_model.dart';

class SesionProvider extends ChangeNotifier {
  String? _token;
  String? get token => _token;

  UserModel? _user;
  UserModel? get user => _user;

  bool get isLogged => _user != null && _token != null;

  Future<void> loadSession() async {
      final userMap = await StorageService.getUser();
    _token = await StorageService.getToken();

    if (userMap != null) {
      _user = UserModel.fromJson(userMap);
    }

    notifyListeners();
  }

  // RECIBE Y ENVIA LOS DATOS PARA GUARDARLOS EN EL STORAGE, Y ACTUALIZA EL ESTADO LOCAL
  Future<void> login(UserModel user, String token) async {
    await StorageService.saveToken(token);
    await StorageService.saveUser(user.toJson());

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
