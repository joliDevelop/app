import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class DinamicBar extends StatelessWidget {
  const DinamicBar({super.key, required this.title, this.showBack = true});

  final String title;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        color: const Color.fromARGB(28, 211, 211, 211),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBack)
              IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppColors.dark,
                ),
              )
            else
              const SizedBox(width: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
