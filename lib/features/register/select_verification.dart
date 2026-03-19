import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/services/auth_service.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/general_service.dart';

class SelectverificationPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const SelectverificationPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
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

            option(
              context,
              Icons.email,
              "Correo electrónico",
              "Recibir código a ${userData["email"]}",

              () async {
                final confirm = await showConfirmDialog(
                  context,
                  title: 'Enviar código por correo',
                  message:
                      '¿Seguro que revisaste tus datos y deseas enviar código por correo?',
                  confirmText: 'Enviar código por correo',
                );

                if (!confirm) return;

                LoadingService.show();
                try {
                  await AuthService.sendVerificationCode(
                    email: userData["email"],
                  );

                  showSuccessSnackBar(context, "Código enviado a tu correo");

                  LoadingService.hide();
                  go(
                    context,
                    '/registro/verification/code',
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
            ),

            // option(
            //   context,
            //   Icons.sim_card,
            //   "Mensaje SMS",
            //   "Recibir código por SIM a (+52) ${userData["telefono"]}",
            //   () {
            //     // llamar endpoint SMS
            //   },
            // ),

            // option(
            //   context,
            //   Icons.sim_card,
            //   "WhatsApp",
            //   "Recibir código por WhatsApp a (+52) ${userData["telefono"]}",
            //   () {
            //     // llamar endpoint whatsapp
            //   },
            // ),
            userInfoCard(userData),

            const SizedBox(height: 58),
          ],
        ),
      ),
    );
  }
}

Widget option(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle,
  VoidCallback onTap,
) {
  return Card(
    elevation: 3,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: const Color.fromARGB(255, 255, 255, 255),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(.1),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    ),
  );
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
