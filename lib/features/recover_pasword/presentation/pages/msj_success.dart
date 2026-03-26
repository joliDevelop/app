import 'package:flutter/material.dart';
// para poder ir a Email app a 3ro
import 'package:url_launcher/url_launcher.dart';
// paleta de colores
import '../../../../core/theme/app_colors.dart';
// barra dinamica de paginas independientes
import '../../../../core/widgets/dinamicbar.dart';
// funciones globales snackbars, navegacion
import '../../../../core/utils/ui_helpers.dart';

class SuccessMessagePage extends StatelessWidget {
  const SuccessMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> openEmailApp() async {
      final gmail = Uri.parse('googlegmail://');
      final outlook = Uri.parse('ms-outlook://');
      final mail = Uri.parse('message://');
      final generic = Uri(scheme: 'mailto');

      if (await canLaunchUrl(gmail)) {
        await launchUrl(gmail, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(outlook)) {
        await launchUrl(outlook, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(mail)) {
        await launchUrl(mail, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(generic, mode: LaunchMode.externalApplication);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Recuperación"),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_rounded,
                  color: Colors.green,
                  size: 60,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "¡Revisa tu correo!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Te enviamos un enlace para recuperar tu contraseña. "
                "Revisa tu bandeja de entrada o spam.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: openEmailApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.mail_outline, color: Colors.white),
                  label: const Text(
                    "Ir al correo",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    go(context, '/login');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.joli),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Volver a iniciar de sesión",
                    style: TextStyle(
                      color: AppColors.joli,
                      fontWeight: FontWeight.w600,
                    ),
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
