import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/widgets/app_input.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/auth_service.dart';
// crear las sesiones
import '../../app/providers/sesion_provider.dart';
import 'package:provider/provider.dart';
import '../../app/services/general_service.dart';

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

  void createPassword() {
    setState(() {
      _passwordError = false;
      _confirmPasswordError = false;
    });

    final password = _password.text;
    final confirm = _confirmPassword.text;

    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&]).{6,}$',
    );

    if (password.isEmpty) {
      setState(() => _passwordError = true);
      showErrorSnackBar(context, "Ingresa una contraseña");
      return;
    }

    if (!passwordRegex.hasMatch(password)) {
      setState(() => _passwordError = true);
      showErrorSnackBar(
        context,
        "La contraseña debe tener mínimo 6 caracteres, un número y un carácter especial",
      );
      return;
    }

    if (confirm.isEmpty) {
      setState(() => _confirmPasswordError = true);
      showErrorSnackBar(context, "Confirma tu contraseña");
      return;
    }

    if (password != confirm) {
      setState(() => _confirmPasswordError = true);
      showErrorSnackBar(context, "Las contraseñas no coinciden");
      return;
    }

    showSuccessSnackBar(context, "Contraseña creada correctamente");
    () async {
      LoadingService.show();
      try {
        final data = await AuthService.createPassword(
          email: widget.userData["email"],
          password: password,
          confirmPassword: confirm,
        );

        showSuccessSnackBar(context, "Cuenta creada correctamente");

        // envio de dados para gurdar en storage
        final auth = context.read<SesionProvider>();
        await auth.login(data['user'], data['token']);

        if (!mounted) return;

        LoadingService.hide();
        go(context, '/home');
      } catch (e) {
        LoadingService.hide();
        showErrorSnackBar(
          context,
          e.toString().replaceFirst("Exception: ", ""),
        );
      }
    }();
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

                onPressed: createPassword,

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

            userInfoCard(userData),

            const SizedBox(height: 58),
          ],
        ),
      ),
    );
  }
}

Widget userInfoCard(Map<String, dynamic> userData) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Corroborar tus datos",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),

        _infoRow(Icons.person, "Nombre", userData["nombre"]),
        _infoRow(
          Icons.badge,
          "Apellidos",
          "${userData["apellidoP"]} ${userData["apellidoM"]}",
        ),
        _infoRow(Icons.cake, "Edad", "${userData["edad"]} años"),
        _infoRow(Icons.phone, "Teléfono", "(+52) ${userData["telefono"]}"),
        _infoRow(Icons.email, "Correo", userData["email"]),
      ],
    ),
  );
}

Widget _infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 14, color: AppColors.primary),
        ),
        const SizedBox(width: 8, height: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
