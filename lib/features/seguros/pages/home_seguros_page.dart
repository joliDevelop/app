// home_seguros_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/seguros_provider.dart';
import '../models/seguro_model.dart';
// funciones globales snackbars, navegacion
import '../../../../core/utils/ui_helpers.dart';

import '../config/seguro_ui_config.dart';
import '../widgets/categoria_card.dart';

class HomeSegurosPage extends StatelessWidget {
  const HomeSegurosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SegurosProvider(),
      child: const _HomeSegurosView(),
    );
  }
}

class _HomeSegurosView extends StatelessWidget {
  const _HomeSegurosView();

  static const _orden = [
    TipoSeguro.gastosMedicosMayores,
    TipoSeguro.vida,
    TipoSeguro.danos,
    TipoSeguro.viaje,
    TipoSeguro.autoYFlotilla,
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Título sección catálogo
          const Text(
            'Elige tu cobertura',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Selecciona el tipo de seguro que necesitas',
            style: TextStyle(fontSize: 13, color: Colors.black45),
          ),

          const SizedBox(height: 20),

          // ── GRID 2 × 3 ──────────────────────────────────────
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.1,
            children: _orden.map((tipo) {
              final cfg = SeguroUI.configs[tipo]!;
            
              return CategoriaCard(
                tipo: tipo,
                cfg: cfg,
                onTap: () => go(context, '/seguro/especifico', extra: tipo),
              );
            }).toList(),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
