import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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

// HISTORIAL DE NAVEGACIONES 
void go(BuildContext context, String path) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
  context.push(path);
}

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
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(cancelText),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text(confirmText),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );

  return result ?? false;
}