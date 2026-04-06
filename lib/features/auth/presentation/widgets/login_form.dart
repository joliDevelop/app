import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/services/loading_service.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/providers/sesion_provider.dart';

import '../providers/auth_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _emailCtrlError = false;
  bool _passwordCtrlError = false;
  bool _showPassword = false;

  Future<void> _login() async {
    if (_emailCtrl.text.isEmpty) {
      setState(() => _emailCtrlError = true);
      showErrorSnackBar(context, 'Ingresa tu correo');
      return;
    }

    if (_passwordCtrl.text.isEmpty) {
      setState(() => _passwordCtrlError = true);
      showErrorSnackBar(context, 'Ingresa tu contraseña');
      return;
    }

    LoadingService.show();

    final authProvider = context.read<AuthProvider>();
    final sesionProvider = context.read<SesionProvider>();

    final response = await authProvider.login(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
      sesionProvider: sesionProvider,
    );

    LoadingService.hide();

    if (!mounted) return;

    if (response['ok']) {
      final user = response['data'].user;
      showSuccessSnackBar(context, 'Bienvenido ${user.nombre}');
      Navigator.pop(context); // 🔥 cierra modal
      go(context, '/home');
    } else {
      showErrorSnackBar(context, response['message'] ?? 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Image.asset('assets/home/joli_1.png', height: 45),

          const SizedBox(height: 20),

          AppInput(
            controller: _emailCtrl,
            hint: "Correo electrónico",
            icon: Icons.mail_outline,
            type: TextInputType.emailAddress,
            hasError: _emailCtrlError,
          ),

          AppInput(
            controller: _passwordCtrl,
            hint: "Contraseña",
            icon: Icons.lock_outline,
            obscure: !_showPassword,
            hasError: _passwordCtrlError,
          ),

          Row(
            children: [
              Checkbox(
                value: _showPassword,
                activeColor: AppColors.joli,
                onChanged: (value) {
                  setState(() => _showPassword = value!);
                },
              ),
              const Text("Mostrar contraseñas"),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.joli,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Iniciar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // GOOGLE
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/google.webp', height: 22),
                  const SizedBox(width: 10),
                  const Text(
                    'Continuar con Google',
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // LINKS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿No tienes cuenta?",
                style: TextStyle(color: Colors.black87, fontSize: 17),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => go(context, '/registro/preregistro'),
                child: Text(
                  "Crear cuenta",
                  style: TextStyle(
                    color: AppColors.joli,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () => go(context, '/recover/password'),
            child: Text(
              "Recuperar contraseña",
              style: TextStyle(
                color: AppColors.joli,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
