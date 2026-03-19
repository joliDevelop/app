// ignore_for_file: control_flow_in_finally

import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/auth_service.dart';
// crear las sesiones
import '../../app/providers/sesion_provider.dart';
import 'package:provider/provider.dart';
import '../../app/widgets/app_input.dart';
import '../../app/services/general_service.dart';

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
  bool _loading = false;
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

    setState(() => _loading = true);

    LoadingService.show();

    try {
      final data = await AuthService.login(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      if (!mounted) return;

      debugPrint('Login OK: $data');
      showSuccessSnackBar(
        context,
        'Bienvenido de nuevo, ${data['user']['nombre']}!',
      );

      // envio de dados para gurdar en storage
      final auth = context.read<SesionProvider>();
      await auth.login(data['user'], data['token']);

      if (!mounted) return;

      // redirige a home
      LoadingService.hide();
      go(context, '/home');
    } catch (e) {
      LoadingService.hide();
      if (!mounted) return;
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      showErrorSnackBar(context, errorMessage);
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
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
                        clipper: _BottomWaveClipper(),
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
                        onPressed: _loading ? null : _login,
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

class _BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    // Arranca abajo-izq
    p.lineTo(0, 50);

    // Curva tipo “ola” como en la captura
    p.cubicTo(
      size.width * 0.22,
      10,
      size.width * 0.55,
      10,
      size.width * 0.78,
      40,
    );

    p.quadraticBezierTo(size.width * 0.90, 55, size.width, 58);

    // Cierra
    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
