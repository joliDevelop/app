import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dinamicbar.dart';
import '../widgets/login_bottom_sheet.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarGlobal(title: "Bienvenido"),
      body: Stack(
        children: [
          // imagen + fade
          SizedBox(
            height: size.height,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  'assets/home/peaple1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: size.height,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.95),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // contenido
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Image.asset('assets/home/joli_1.png', height: 55),

                const SizedBox(height: 10),

                const Text(
                  "Bienvenido a Joli",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => LoginBottomSheet.show(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.joli,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Continuar",
                      style: TextStyle(fontSize: 18, color: AppColors.background),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
