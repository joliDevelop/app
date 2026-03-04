import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/providers/sesion_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SesionProvider()..loadSession(),
      child: const App(),
    ),
  );
}