import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/seguro_model.dart';

class SimuladorSheet extends StatefulWidget {
  final SeguroModel seguro;

  const SimuladorSheet({super.key, required this.seguro});

  static void show(BuildContext context, SeguroModel seguro) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SimuladorSheet(seguro: seguro),
    );
  }

  @override
  State<SimuladorSheet> createState() => _SimuladorSheetState();
}

class _SimuladorSheetState extends State<SimuladorSheet> {
  int _meses = 12;

  double get _total => widget.seguro.precioMensual * _meses;
  double get _totalConDescuento => _total * 0.9;
  bool get _aplicaDescuento => _meses >= 12;

  @override
  Widget build(BuildContext context) {
    final esVida = widget.seguro.tipo == TipoSeguro.vida;
    final color = esVida ? AppColors.primary : AppColors.navy;

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HANDLE
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TITULO
          Text(
            'Simular: ${widget.seguro.nombre}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '\$${widget.seguro.precioMensual.toStringAsFixed(0)} por mes',
            style: TextStyle(fontSize: 14, color: color),
          ),

          const SizedBox(height: 28),

          // SLIDER MESES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meses a contratar',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
              Text(
                '$_meses meses',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),

          Slider(
            value: _meses.toDouble(),
            min: 1,
            max: 24,
            divisions: 23,
            activeColor: color,
            inactiveColor: color.withOpacity(.2),
            onChanged: (v) => setState(() => _meses = v.toInt()),
          ),

          const SizedBox(height: 20),

          // RESULTADO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(.2)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total sin descuento',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    Text(
                      '\$${_total.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        decoration: _aplicaDescuento
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
                if (_aplicaDescuento) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Total anual',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '10% OFF',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$${_totalConDescuento.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          // BOTON CONTRATAR
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Solicitar asesoría',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}