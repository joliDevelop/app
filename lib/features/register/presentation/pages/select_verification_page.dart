// Paso 2

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// paleta de colores
import '../../../../core/theme/app_colors.dart';
// barra dinamica 
import '../../../../core/widgets/dinamicbar.dart';
// funciones globales snackbars, navegacion, pregunta de confirmación 
import '../../../../core/utils/ui_helpers.dart';
// spinner 
import '../../../../core/services/loading_service.dart';
// provider propio
import '../../presentation/providers/register_provider.dart';
// widget propio
import '../../presentation/widgets/register_widget.dart';

class SelectverificationPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  const SelectverificationPage({super.key, required this.userData});

  Future<void> _sendCode(BuildContext context) async {
    final confirm = await showConfirmDialog(
      context,
      title: 'Enviar código por correo',
      message: '¿Seguro que deseas enviar código?',
      confirmText: 'Enviar código',
    );

    if (!confirm) return;

    LoadingService.show();

    try {
      final provider = context.read<RegisterProvider>();

      await provider.sendVerificationCode();

      LoadingService.hide();

      showSuccessSnackBar(context, "Código enviado");
      go(context, '/registro/verification/code', extra: userData);
    } catch (e) {
      LoadingService.hide();

      showErrorSnackBar(context, e.toString().replaceFirst("Exception: ", ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final user = provider.buildUser();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Metodo de Verificar"),

      body: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Elige cómo quieres recibir tu código de verificación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 18),

            OptionVerificate(
              icon: Icons.email,
              title: "Correo electrónico",
              subtitle: "Recibir código a ${user.email}",
              onTap: () => _sendCode(context),
            ),

            // REPLICA LA CARTA DE WHATSAPP Y DE SMS
            //   Icons.sim_card,

            UserInfoCard(userData: userData),

            const SizedBox(height: 58),
          ],
        ),
      ),
    );
  }
}
