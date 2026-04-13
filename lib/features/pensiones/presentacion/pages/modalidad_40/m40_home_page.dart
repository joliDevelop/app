import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/dinamicbar.dart';

class Modalidad40 extends StatelessWidget {
  const Modalidad40({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppBarGlobal(title: "Modalidad 40"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // _headerCard(),
          const SizedBox(height: 20),
          _accionesGrid(context),
          const SizedBox(height: 20),
          _infoCard(
            title: "¿Vale la pena?",
            content:
                "Sí, si buscas aumentar tu pensión. Esta modalidad te permite cotizar con un salario mayor al último registrado.",
          ),
          const SizedBox(height: 12),
          _infoCard(
            title: "Dato clave",
            content:
                "Entre más alto el salario con el que cotices, mayor será tu pensión mensual.",
          ),
        ],
      ),
    );
  }

  // 🧩 Grid de acciones
  static Widget _accionesGrid(BuildContext context) {
    final items = [
      _AccionItem(
        icon: Icons.calculate,
        title: "Simular",
        onTap: () => _showModal(
          context,
          "Simulación",
          "Aquí podrás calcular cuánto podrías recibir de pensión según tu salario.",
        ),
      ),
      _AccionItem(
        icon: Icons.rule,
        title: "Requisitos",
        onTap: () => _showModal(
          context,
          "Requisitos",
          "• Tener mínimo 52 semanas cotizadas\n• No estar activo en el IMSS\n• Haber cotizado antes de 1997",
        ),
      ),
      _AccionItem(
        icon: Icons.attach_money,
        title: "Costos",
        onTap: () => _showModal(
          context,
          "Costos",
          "El pago depende del salario con el que decidas cotizar. Entre más alto, mayor inversión.",
        ),
      ),
      _AccionItem(
        icon: Icons.trending_up,
        title: "Beneficios",
        onTap: () => _showModal(
          context,
          "Beneficios",
          "• Aumenta tu pensión\n• Control sobre tu cotización\n• Mejor retiro",
        ),
      ),
    ];

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (_, i) => items[i],
    );
  }

  // 📄 Card secundaria
  static Widget _infoCard({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }

  // 📱 Modal inferior
  static void _showModal(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(content, style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

// 🔘 Item del grid
class _AccionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _AccionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
