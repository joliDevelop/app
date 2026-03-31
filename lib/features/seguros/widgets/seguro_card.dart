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

  @override
  Widget build(BuildContext context) {
    final esVida = seguro.tipo == TipoSeguro.vida;
    final color = esVida ? AppColors.navy : AppColors.navy;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER: ícono + nombre + badge tipo
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    esVida ? Icons.favorite_outline : Icons.medical_services_outlined,
                    color: color,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seguro.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          esVida ? 'Vida' : 'Gastos Médicos',
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // DESCRIPCION
            Text(
              seguro.descripcion,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            // BENEFICIOS
            ...seguro.beneficios.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: color, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      b,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PRECIO + BOTONES
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Desde',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    Text(
                      '\$${seguro.precioMensual.toStringAsFixed(0)}/mes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: onSimular,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: color.withOpacity(.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Simular',
                    style: TextStyle(color: color, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onVerDetalle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Ver más',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}