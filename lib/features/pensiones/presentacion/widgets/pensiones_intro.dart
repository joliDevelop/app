import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PensionesIntro extends StatelessWidget {
  const PensionesIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 15, color: AppColors.dark),
        children: [
          TextSpan(text: "Te ayudamos a "),
          TextSpan(
            text: "optimizar y gestionar tu ahorro",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                " para el retiro. Identificamos oportunidades reales, no promesas vacías.",
          ),
        ],
      ),
    );
  }
}