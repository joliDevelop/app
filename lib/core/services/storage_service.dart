import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _storage = FlutterSecureStorage();

  static const _tokenKey = 'token';
  static const _userKey = 'user';

  // Guardar token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Guardar usuario
  static Future<void> saveUser(Map<String, dynamic> user) async {
    final userJson = jsonEncode(user);
    await _storage.write(key: _userKey, value: userJson);
  }

  // Obtener token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Obtener usuario
  static Future<Map<String, dynamic>?> getUser() async {
    final userString = await _storage.read(key: _userKey);

    if (userString == null) return null;

    return jsonDecode(userString);
  }

  // Logout
  static Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}