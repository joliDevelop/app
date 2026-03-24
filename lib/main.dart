import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app.dart';
import 'core/providers/sesion_provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/register/presentation/providers/register_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SesionProvider()..loadSession()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: const App(),
    ),
  );
}
