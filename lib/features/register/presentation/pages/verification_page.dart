// Paso 3

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// para usar el Timer 
import 'dart:async';
// paleta de colores 
import '../../../../core/theme/app_colors.dart';
// barra dinamica de paginas individuales 
import '../../../../core/widgets/dinamicbar.dart';
// funciones globales snackbars, navegacion, pregunta de confirmación 
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/services/loading_service.dart';
// provider propio
import '../../presentation/providers/register_provider.dart';
// widget propio
import '../../presentation/widgets/register_widget.dart';

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

  int _secondsLeft = 0;
  Timer? _timer;

  Future<void> _verify() async {
    final provider = context.read<RegisterProvider>();

    final verificationCode = code;

    if (verificationCode.length != 6) {
      showErrorSnackBar(context, "Ingresa el código completo");
      return;
    }

    LoadingService.show();

    try {
      await provider.verifyCode(verificationCode);

      LoadingService.hide();

      if (!mounted) return;

      showSuccessSnackBar(context, "Código verificado correctamente");

      go(context, '/registro/create/password', extra: widget.userData);
    } catch (e) {
      LoadingService.hide();

      showErrorSnackBar(context, e.toString().replaceFirst("Exception: ", ""));
    }
  }

  Future<void> _resend() async {
    if (_secondsLeft > 0) return;

    final confirm = await showConfirmDialog(
      context,
      title: 'Reenviar código',
      message: '¿Seguro que deseas reenviar código?',
      confirmText: 'Enviar código',
    );

    if (!confirm) return;

    final provider = context.read<RegisterProvider>();

    LoadingService.show();

    try {
      await provider.resendCode();

      LoadingService.hide();

      if (!mounted) return;

      showSuccessSnackBar(context, "Código reenviado");

      _startCountdown(); // 🔥 aquí empieza el timer
    } catch (e) {
      LoadingService.hide();

      showErrorSnackBar(context, e.toString().replaceFirst("Exception: ", ""));
    }
  }

  void _startCountdown() {
    _secondsLeft = 60;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
              children: List.generate(6, (index) {
                return OtpBox(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      focusNodes[index + 1].requestFocus();
                    }
                    if (value.isEmpty && index > 0) {
                      focusNodes[index - 1].requestFocus();
                    }
                  },
                );
              }),
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
                onPressed: _verify,
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
              onPressed: _secondsLeft > 0 ? null : _resend,
              child: Text(
                _secondsLeft > 0
                    ? "Reenviar en $_secondsLeft s"
                    : "Reenviar código",
                style: TextStyle(
                  color: _secondsLeft > 0 ? Colors.grey : AppColors.navy,
                ),
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
