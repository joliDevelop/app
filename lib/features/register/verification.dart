import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';

import '../../app/services/auth_service.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/general_service.dart';

class VerificationPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const VerificationPage({super.key, required this.userData});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String get code => controllers.map((c) => c.text).join();

  Widget otpBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = widget.userData;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Verificar identidad"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Ingresa el código de verificación",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Enviamos un código a ${userData["email"]}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => otpBox(index)),
            ),

            const SizedBox(height: 40),

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
                onPressed: () async {
                  final verificationCode = code;

                  if (verificationCode.length != 6) {
                    showErrorSnackBar(context, "Ingresa el código completo");
                    return;
                  }

                  LoadingService.show();
                  try {
                    await AuthService.verifyCode(
                      email: userData["email"],
                      codigo: verificationCode,
                    );

                    showSuccessSnackBar(
                      context,
                      "Código verificado correctamente",
                    );

                    LoadingService.hide();
                    go(
                      context,
                      '/registro/create/password',
                      extra: {
                        "nombre": userData["nombre"],
                        "apellidoP": userData["apellidoP"],
                        "apellidoM": userData["apellidoM"],
                        "edad": userData["edad"],
                        "telefono": userData["telefono"],
                        "email": userData["email"],
                      },
                    );
                  } catch (e) {
                    LoadingService.hide();
                    showErrorSnackBar(
                      context,
                      e.toString().replaceFirst("Exception: ", ""),
                    );
                  }
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Verificar código",
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

            const SizedBox(height: 30),

            const Text(
              "¿No recibiste el código?",
              style: TextStyle(color: Colors.grey),
            ),

            TextButton(
              onPressed: () {
                () async {
                  LoadingService.show();
                  try {
                    await AuthService.sendVerificationCode(
                      email: userData["email"],
                    );

                    LoadingService.hide();
                    showSuccessSnackBar(context, "Código enviado a tu correo");
                  } catch (e) {
                    LoadingService.hide();
                    showErrorSnackBar(
                      context,
                      e.toString().replaceFirst("Exception: ", ""),
                    );
                  }
                }();
              },
              child: const Text("Reenviar código"),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
