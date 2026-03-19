// Funciones globales para manejar UI como mostrar snackbars,
// navegar entre pantallas o mostrar diálogos de confirmación.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

// DANGER ALERT
void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// SUCCESS ALERT
void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

// HISTORIAL DE NAVEGACIONES Y ASÍ PODER NAVEGAR ENTRE PANTALLAS
void go(BuildContext context, String path, {Object? extra}) {
  context.push(path, extra: extra);
}

// MODAL DIALOG PARA PREGUNTAR SI EL USUARIO ESTA SEGURO DE REALIZAR UNA ACCION
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Aceptar',
  String cancelText = 'Cancelar',
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white, // 🔥 adiós gris feo
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ICONO
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.joli.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.help_outline,
                  color: AppColors.joli,
                  size: 30,
                ),
              ),

              const SizedBox(height: 18),

              // TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              // MESSAGE
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // BOTONES
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.joli,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          textAlign: TextAlign.center,
                          maxLines: 2, //  salto de línea
                          overflow:
                              TextOverflow.ellipsis, // por si se pasa demasiado
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.2, // el espaciado vertical
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}
