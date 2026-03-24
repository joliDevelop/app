// PASO 4

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/app_input.dart';
// paleta de colores
import '../../../../core/theme/app_colors.dart';
// barra dinamica
import '../../../../core/widgets/dinamicbar.dart';
// funciones globales snackbars, navegacion
import '../../../../core/utils/ui_helpers.dart';
// spinner
import '../../../../core/services/loading_service.dart';
// provider propio
import '../../presentation/providers/register_provider.dart';
// widget propio
import '../../presentation/widgets/register_widget.dart';
// crear las sesiones
import '../../../../core/providers/sesion_provider.dart';
// Modelos del login del user 
import '../../../../features/auth/data/models/user_model.dart';

class CreatePasswordPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const CreatePasswordPage({super.key, required this.userData});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _showPassword = false;

  Future<void> _createPassword() async {
    final provider = context.read<RegisterProvider>();

    setState(() {
      _passwordError = false;
      _confirmPasswordError = false;
    });

    LoadingService.show();

    try {
      final data = await provider.createPassword(
        password: _password.text,
        confirmPassword: _confirmPassword.text,
      );

      LoadingService.hide();

      if (!mounted) return;

      showSuccessSnackBar(context, "Cuenta creada correctamente");
      final auth = context.read<SesionProvider>();

      final user = UserModel.fromJson(data['user']); 

      await auth.login(user, data['token']);

      go(context, '/home');
    } catch (e) {
      LoadingService.hide();

      final msg = e.toString();

      setState(() {
        if (msg.contains("contraseña")) {
          _passwordError = true;
        }
        if (msg.contains("coinciden")) {
          _confirmPasswordError = true;
        }
      });

      showErrorSnackBar(context, msg.replaceFirst("Exception: ", ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Crear contraseña"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage('assets/home/joli_1.png'),
                    height: 45,
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Crea una contraseña segura para continuar",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            AppInput(
              controller: _password,
              hint: "Crear contraseña",
              icon: Icons.lock,
              obscure: !_showPassword,
              hasError: _passwordError,
              onChanged: (value) {
                if (value.isNotEmpty && _passwordError) {
                  setState(() => _passwordError = false);
                }
              },
            ),

            AppInput(
              controller: _confirmPassword,
              hint: "Confirmar contraseña",
              icon: Icons.lock_outline,
              obscure: !_showPassword,
              hasError: _confirmPasswordError,
              onChanged: (value) {
                if (value.isNotEmpty && _confirmPasswordError) {
                  setState(() => _confirmPasswordError = false);
                }
              },
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Checkbox(
                  value: _showPassword,
                  onChanged: (value) {
                    setState(() {
                      _showPassword = value!;
                    });
                  },
                ),

                const Text("Mostrar contraseñas"),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.joli,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                onPressed: _createPassword,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Crear contraseña",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            UserInfoCard(userData: userData),

            const SizedBox(height: 58),
          ],
        ),
      ),
    );
  }
}
