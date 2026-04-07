import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoginIndicator extends StatelessWidget {
  final int currentPage;
  final int total;

  const LoginIndicator({
    super.key,
    required this.currentPage,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final isActive = currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ?  AppColors.joli : Colors.white38,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}