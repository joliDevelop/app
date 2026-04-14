import 'package:flutter/material.dart';

import '../pages/asesoria_page.dart';
import '../../../../core/theme/app_colors.dart';

class AsesoriaModal extends StatelessWidget {
  const AsesoriaModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.textMuted.withOpacity(0.35),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Expanded(
            child: AsesoriaPage(esModal: true),
          ),
        ],
      ),
    );
  }
}