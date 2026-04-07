import 'package:flutter/material.dart';
import '../config/seguro_ui_config.dart';
import '../models/seguro_model.dart';

class CategoriaCard extends StatelessWidget {
  final TipoSeguro tipo;
  final SeguroUIConfig cfg;
  final VoidCallback onTap;

  const CategoriaCard({
    super.key,
    required this.tipo,
    required this.cfg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = SeguroUI.getGradient(tipo);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: gradient.first.withOpacity(.35),
          //     blurRadius: 16,
          //     offset: const Offset(0, 8),
          //   ),
          // ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(cfg.icono, color: Colors.white, size: 28),
                  ),

                  const Spacer(),

                  Text(
                    cfg.label,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),

                 
                ],
              ),
            ),

            Positioned(
              top: 14,
              right: 14,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(.6),
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}