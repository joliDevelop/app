// page login

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// paleta de colores
import '../../../../core/theme/app_colors.dart';
// top bar de paginas independientes (go)
import '../../../../core/widgets/dinamicbar.dart';
// funciones globales de ui (alerts, snackbar)
import '../../../../core/utils/ui_helpers.dart';
// formato imput
import '../../../../core/widgets/app_input.dart';
// spinner
import '../../../../core/services/loading_service.dart';
// crear las sesiones
import '../../../../core/providers/sesion_provider.dart';

// ----- / -----
// Widget propio
import '../widgets/bottom_wave_clipper.dart';
// provider propio
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _emailCtrlError = false;
  bool _passwordCtrlError = false;
  bool _showPassword = false;
  double _headerFactor = 0.40;

  Future<void> _login() async {
    if (_emailCtrl.text.isEmpty) {
      setState(() => _emailCtrlError = true);
      showErrorSnackBar(context, 'Ingresa tu correo');
      return;
    }

    if (_passwordCtrl.text.isEmpty) {
      setState(() => _passwordCtrlError = true);
      showErrorSnackBar(context, 'Ingresa tu contraseña');
      return;
    }

    LoadingService.show();

    final authProvider = context.read<AuthProvider>();
    final sesionProvider = context.read<SesionProvider>();

    final response = await authProvider.login(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
      sesionProvider: sesionProvider,
    );

    LoadingService.hide();

    if (!mounted) return;

    if (response['ok']) {
      final user = response['data'].user;

      showSuccessSnackBar(context, 'Bienvenido de nuevo, ${user.nombre}!');

      go(context, '/home');
    } else {
      showErrorSnackBar(context, response['message'] ?? 'Error desconocido');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _headerFactor = 0.15;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * _headerFactor;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const AppBarGlobal(title: "Inicia sesión"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                height: headerHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/home/peaple1.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -1,
                      child: ClipPath(
                        clipper: BottomWaveClipper(),
                        child: Container(height: 60, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/home/joli_1.png',
                      height: 45,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 7),

                    AppInput(
                      controller: _emailCtrl,
                      hint: "Correo electrónico",
                      icon: Icons.mail_outline,
                      type: TextInputType.emailAddress,
                      hasError: _emailCtrlError,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _emailCtrlError = false;
                          } else if (!value.contains('@')) {
                            _emailCtrlError = true;
                          } else {
                            _emailCtrlError = false;
                          }
                        });
                      },
                    ),

                    AppInput(
                      controller: _passwordCtrl,
                      hint: "Contraseña",
                      icon: Icons.lock_outline,
                      obscure: !_showPassword,
                      hasError: _passwordCtrlError,
                      onChanged: (value) {
                        if (value.isNotEmpty && _passwordCtrlError) {
                          setState(() => _passwordCtrlError = false);
                        }
                      },
                    ),

                    Row(
                      children: [
                        Checkbox(
                          value: _showPassword,
                          activeColor: AppColors.joli,
                          onChanged: (value) {
                            setState(() {
                              _showPassword = value!;
                            });
                          },
                        ),
                        const Text("Mostrar contraseñas"),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.joli,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Iniciar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                            side: const BorderSide(color: Color(0xFFDDDDDD)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/google.webp', height: 22),
                            const SizedBox(width: 12),
                            const Text(
                              'Continuar con Google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿No tienes cuenta?',
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            go(context, '/registro/preregistro');
                          },
                          child: Text(
                            'Crear cuenta',
                            style: TextStyle(
                              color: AppColors.joli,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            go(context, '/recover/password');
                          },
                          child: Text(
                            'Recuperar contraseña',
                            style: TextStyle(
                              color: AppColors.joli,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
