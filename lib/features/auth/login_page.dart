// ignore_for_file: control_flow_in_finally

import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/services/auth_service.dart';
import '../../app/providers/sesion_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _loading = false;

  Future<void> _login() async {
    if (_emailCtrl.text.isEmpty) {
      showErrorSnackBar(context, 'Ingresa tu correo');
      return;
    }

    if (_passwordCtrl.text.isEmpty) {
      showErrorSnackBar(context, 'Ingresa tu contraseña');
      return;
    }

    setState(() => _loading = true);

    try {
      final data = await AuthService.login(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      if (!mounted) return;

      debugPrint('Login OK: $data');
      showSuccessSnackBar(context, 'Login exitoso');

      // envio de dados para gurdar en storage 
      final auth = context.read<SesionProvider>();
      await auth.login(data['user'], data['token']);

      if (!mounted) return;
      
      // redirige a home 
      go(context, '/home');
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, e.toString());
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.32;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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

                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: DinamicBar(title: 'Back'),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -1,
                      child: ClipPath(
                        clipper: _BottomWaveClipper(),
                        child: Container(height: 80, color: Colors.white),
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
                    const SizedBox(height: 12),
                    const Text(
                      'Inicia sesión',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 22),

                    _Input(
                      controller: _emailCtrl,
                      hint: 'Correo electronico',
                      suffix: const Icon(Icons.mail_outline, size: 20),
                      obscure: false,
                    ),
                    const SizedBox(height: 16),
                    _Input(
                      controller: _passwordCtrl,
                      hint: 'Contraseña',
                      suffix: const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 20,
                      ),
                      obscure: true,
                    ),

                    const SizedBox(height: 26),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Iniciar',
                                style: TextStyle(fontSize: 17),
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

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿No tienes cuenta?',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            // Navegar a registro
                          },
                          child: Text(
                            'Crear cuenta',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
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

class _Input extends StatelessWidget {
  const _Input({
    required this.hint,
    required this.suffix,
    required this.obscure,
    required this.controller,
  });

  final String hint;
  final Widget suffix;
  final bool obscure;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 91, 91, 91),
            fontSize: 19,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconTheme(
              data: const IconThemeData(color: Color(0xFFB9B9B9)),
              child: suffix,
            ),
          ),
          suffixIconConstraints: const BoxConstraints(minWidth: 44),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 111, 155),
              width: 1,
            ),
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
