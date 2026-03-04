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