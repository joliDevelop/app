import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/widgets/app_input.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/auth_service.dart';

import '../../app/services/general_service.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _email = TextEditingController();

  bool _emailError = false;
  bool _loading = false;

  Future<void> _recover() async {
    setState(() {
      _emailError = false;
    });

    if (_email.text.isEmpty) {
      setState(() => _emailError = true);
      showErrorSnackBar(context, "Ingresa tu correo electrónico");
      return;
    }

    setState(() => _loading = true);
    LoadingService.show();

    try {
      await AuthService.recoverPassword(email: _email.text);

      if (!mounted) return;

      showSuccessSnackBar(
        context,
        "Revisa tu correo para continuar con la recuperación",
      );

      LoadingService.hide();
      go(context, '/recover/success/msj');
    } catch (e) {
      LoadingService.hide();
      if (!mounted) return;

      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      showErrorSnackBar(context, errorMessage);
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Recuperar contraseña"),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              
              // Logo de joli
              Image.asset(
                'assets/home/joli_1.png',
                height: 45,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              const Text(
                "Ingresa tu correo electrónico para recuperar tu contraseña",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),

              const SizedBox(height: 20),

              // imput para ingresar el correo electrónico del usuario, 
              // con validación de error y tipo de teclado para email
              AppInput(
                controller: _email,
                hint: "Correo electrónico",
                icon: Icons.email,
                hasError: _emailError,
                type: TextInputType.emailAddress,
                onChanged: (value) {
                  if (value.isNotEmpty && _emailError) {
                    setState(() => _emailError = false);
                  }
                },
              ),

              const SizedBox(height: 25),

              // boton para verificar y enviar el correo de recuperación, 
              // si el proceso es exitoso se redirige a la pantalla de mensaje de éxito, 
              // si hay un error se muestra un mensaje de error 
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _loading ? null : _recover,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.joli,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.email_outlined, color: Colors.white),
                  label: const Text(
                    "Enviar enlace de recuperación",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Volver al inicio de sesión",
                  style: TextStyle(
                    color: AppColors.joli,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
