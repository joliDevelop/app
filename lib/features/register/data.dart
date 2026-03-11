import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/services/auth_service.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/widgets/dinamicbar.dart';

class RegisterDataPage extends StatefulWidget {
  const RegisterDataPage({super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  final _nombre = TextEditingController();
  final _apellidoP = TextEditingController();
  final _apellidoM = TextEditingController();
  final _edad = TextEditingController();
  final _numSeguro = TextEditingController();
  final _email = TextEditingController();
  final _telefono = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _loading = false;

  Future<void> _register() async {
    if (_nombre.text.isEmpty) {
      showErrorSnackBar(context, "Ingresa tu nombre");
      return;
    }

    if (_email.text.isEmpty) {
      showErrorSnackBar(context, "Ingresa tu email");
      return;
    }

    if (_password.text != _confirmPassword.text) {
      showErrorSnackBar(context, "Las contraseñas no coinciden");
      return;
    }

    setState(() => _loading = true);

    try {
      await AuthService.register(
        nombre: _nombre.text,
        apellidoP: _apellidoP.text,
        apellidoM: _apellidoM.text,
        edad: int.parse(_edad.text),
        numesocial: _numSeguro.text,
        email: _email.text,
        password: _password.text,
        confirmPassword: _confirmPassword.text,
        lada: "+52",
        telefono: _telefono.text,
      );

      if (!mounted) return;

      showSuccessSnackBar(context, "Cuenta creada correctamente");

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, e.toString());
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Widget input(
    TextEditingController ctrl,
    String hint, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.navy),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Crear cuenta"),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              input(_nombre, "Nombre"),
              input(_apellidoP, "Apellido paterno"),
              input(_apellidoM, "Apellido materno"),
              input(_edad, "Edad", type: TextInputType.number),

              // input(_numSeguro, "Número de seguro social"),
              input(_telefono, "Teléfono", type: TextInputType.phone),

              input(
                _email,
                "Correo electrónico",
                type: TextInputType.emailAddress,
              ),

              // input(_password, "Contraseña", obscure: true),
              // input(_confirmPassword, "Confirmar contraseña", obscure: true),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Crear cuenta",
                          style: TextStyle(fontSize: 17),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿Ya tienes cuenta? "),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
