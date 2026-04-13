import 'package:flutter/material.dart';
import 'package:joli/features/asesoria/presentacion/pages/asesoria_page.dart';

class AsesoriaModal extends StatelessWidget {
  const AsesoriaModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F7FB),
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
              color: Colors.black26,
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