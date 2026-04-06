import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/seguro_model.dart';

class SeguroCard extends StatelessWidget {
  final SeguroModel seguro;
  final VoidCallback onVerDetalle;
  final VoidCallback onSimular;

  const SeguroCard({
    super.key,
    required this.seguro,
    required this.onVerDetalle,
    required this.onSimular,
  });

  // Colores y configuración por tipo
  _TipoConfig _getConfig() {
    switch (seguro.tipo) {
      case TipoSeguro.gastosMedicosMayores:
        return _TipoConfig(
          color: const Color(0xFF00BCD4),
          icono: Icons.local_hospital_rounded,
          gradiente: [const Color(0xFF00BCD4), const Color(0xFF0097A7)],
        );
      case TipoSeguro.vida:
        return _TipoConfig(
          color: const Color(0xFF1A3A5C),
          icono: Icons.favorite_rounded,
          gradiente: [const Color(0xFF1A3A5C), const Color(0xFF0D2137)],
        );
      case TipoSeguro.danos:
        return _TipoConfig(
          color: const Color(0xFFFF6B35),
          icono: Icons.home_rounded,
          gradiente: [const Color(0xFFFF6B35), const Color(0xFFE55A25)],
        );
      case TipoSeguro.viaje:
        return _TipoConfig(
          color: const Color(0xFF6C63FF),
          icono: Icons.flight_rounded,
          gradiente: [const Color(0xFF6C63FF), const Color(0xFF5A52E0)],
        );
      case TipoSeguro.autoYFlotilla:
        return _TipoConfig(
          color: const Color(0xFF2ECC71),
          icono: Icons.directions_car_rounded,
          gradiente: [const Color(0xFF2ECC71), const Color(0xFF27AE60)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _getConfig();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cfg.color.withOpacity(.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── HEADER con gradiente ──────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: cfg.gradiente,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
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
                    color: Colors.white.withOpacity(.2),
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
                          color: Colors.white,
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
                          color: Colors.white.withOpacity(.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          seguro.tipo.label,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
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
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                    Text(
                      '\$${seguro.precioMensual.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                    color: cfg.color.withOpacity(.05),
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
                                color: cfg.color.withOpacity(.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                color: cfg.color,
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
                    // Simular — outlined
                    // Expanded(
                    //   child: OutlinedButton.icon(
                    //     onPressed: onSimular,
                    //     icon: Icon(
                    //       Icons.calculate_outlined,
                    //       size: 16,
                    //       color: cfg.color,
                    //     ),
                    //     label: Text(
                    //       'Simular',
                    //       style: TextStyle(
                    //         color: cfg.color,
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 13,
                    //       ),
                    //     ),
                    //     style: OutlinedButton.styleFrom(
                    //       side: BorderSide(color: cfg.color.withOpacity(.5)),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(vertical: 12),
                    //     ),
                    //   ),
                    // ),
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
                          backgroundColor: cfg.color,
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

// Clase auxiliar de configuración visual por tipo
class _TipoConfig {
  final Color color;
  final IconData icono;
  final List<Color> gradiente;

  const _TipoConfig({
    required this.color,
    required this.icono,
    required this.gradiente,
  });
}
