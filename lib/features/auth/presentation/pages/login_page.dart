import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/dinamicbar.dart';
import '../widgets/login_bottom_sheet.dart';
import '../widgets/login_carousel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const AppBarGlobal(title: "Bienvenido"),
      body: Stack(
        children: [
          const SizedBox.expand(child: LoginCarousel()),

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
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4), 
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => LoginBottomSheet.show(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.joli,
                      elevation: 0, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Continuar",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.background,
                      ),
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
