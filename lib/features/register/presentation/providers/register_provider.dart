import 'package:flutter/material.dart';
import '../../data/services/register_api_service.dart';
import '../../data/models/register_user_model.dart';

class RegisterProvider with ChangeNotifier {
  // Controllers
  final nombre = TextEditingController();
  final apellidoP = TextEditingController();
  final apellidoM = TextEditingController();
  final edad = TextEditingController();
  final telefono = TextEditingController();
  final email = TextEditingController();

  // Estado
  bool loading = false;

  // Errores
  bool nombreError = false;
  bool apellidoPError = false;
  bool apellidoMError = false;
  bool edadError = false;
  bool telefonoError = false;
  bool emailError = false;

  void resetErrors() {
    nombreError = false;
    apellidoPError = false;
    apellidoMError = false;
    edadError = false;
    telefonoError = false;
    emailError = false;
  }

  bool validate() {
    resetErrors();

    if (nombre.text.isEmpty) {
      nombreError = true;
      return false;
    }

    if (apellidoP.text.isEmpty) {
      apellidoPError = true;
      return false;
    }

    if (apellidoM.text.isEmpty) {
      apellidoMError = true;
      return false;
    }

    final edadInt = int.tryParse(edad.text);
    if (edadInt == null || edadInt < 18 || edadInt > 100) {
      edadError = true;
      return false;
    }

    if (telefono.text.length != 10) {
      telefonoError = true;
      return false;
    }

    if (email.text.isEmpty) {
      emailError = true;
      return false;
    }

    return true;
  }

  RegisterUser buildUser() {
    return RegisterUser(
      nombre: nombre.text,
      apellidop: apellidoP.text,
      apellidom: apellidoM.text,
      edad: int.parse(edad.text),
      telefono: telefono.text,
      email: email.text,
    );
  }

  // ----- -----
  // paso 1
  Future<RegisterUser?> register() async {
    if (!validate()) {
      notifyListeners();
      return null;
    }

    loading = true;
    notifyListeners();

    try {
      final user = buildUser();

      await RegisterService.preregister(user);

      return user;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  // ----- -----
  // paso 2
  Future<bool> sendVerificationCode() async {
    try {
      final user = buildUser();

      await RegisterService.sendVerificationCode(email: user.email);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  // ----- -----
  // paso 3
  Future<void> verifyCode(String code) async {
    final user = buildUser();

    await RegisterService.verifyCode(email: user.email, codigo: code);
  }

  Future<void> resendCode() async {
    final user = buildUser();

    await RegisterService.sendVerificationCode(email: user.email);
  }

  // ----- -----
  // paso 4
  Future<Map<String, dynamic>> createPassword({
    required String password,
    required String confirmPassword,
  }) async {
    final user = buildUser();

    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&]).{6,}$',
    );

    if (password.isEmpty) {
      throw Exception("Ingresa una contraseña");
    }

    if (!passwordRegex.hasMatch(password)) {
      throw Exception(
        "La contraseña debe tener mínimo 6 caracteres, un número y un carácter especial",
      );
    }

    if (confirmPassword.isEmpty) {
      throw Exception("Confirma tu contraseña");
    }

    if (password != confirmPassword) {
      throw Exception("Las contraseñas no coinciden");
    }

    return await RegisterService.createPassword(
      email: user.email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
