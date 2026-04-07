import 'package:flutter/material.dart';
// import '../../../../core/theme/app_colors.dart';
import '../models/seguro_model.dart';
import '../config/seguro_ui_config.dart';

class SeguroCard extends StatelessWidget {
  final SeguroModel seguro;
  final VoidCallback onVerDetalle;

  const SeguroCard({
    super.key,
    required this.seguro,
    required this.onVerDetalle,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = SeguroUI.configs[seguro.tipo]!;
    final gradient = SeguroUI.getGradient(seguro.tipo);
    final primaryColor = gradient.first;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(top: BorderSide(color: primaryColor, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── HEADER con gradiente ──────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Ícono circular
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cfg.icono, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                // Nombre + badge tipo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seguro.nombre,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          seguro.tipo.label,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600,
                            letterSpacing: .3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Precio compacto en header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Desde',
                      style: TextStyle(fontSize: 11, color: Color.fromARGB(179, 0, 0, 0)),
                    ),
                    Text(
                      '\$${seguro.precioMensual.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const Text(
                      'por mes',
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── BODY ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descripción
                Text(
                  seguro.descripcion,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 14),

                // Beneficios con fondo sutil
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: seguro.beneficios.map((b) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                color: primaryColor,
                                size: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                b,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()..last, // quita padding del último
                  ),
                ),

                const SizedBox(height: 16),

                // ── BOTONES ───────────────────────────────────
                Row(
                  children: [
                   
                    const SizedBox(width: 10),
                    // Ver más — filled
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onVerDetalle,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Ver más',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
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
    );
  }
}
