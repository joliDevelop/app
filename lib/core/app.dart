// configuración de la app
import 'package:flutter/material.dart';
import 'router.dart';
import 'providers/sesion_provider.dart';

class App extends StatefulWidget {
  const App({super.key, required this.sesionProvider});

  final SesionProvider sesionProvider;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = buildRouter(widget.sesionProvider);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
