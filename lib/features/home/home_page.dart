import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HERO
          Text(
            'Especialistas en tu\nfuturo financiero',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 2, 53, 70),
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Pensiones · Inversión · Seguros · Retiro',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: 32),

          // MÓDULOS
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: const [
              _ModuleCard(
                title: 'Pensiones',
                icon: Icons.shield,
              ),
              _ModuleCard(
                title: 'Inversión',
                icon: Icons.trending_up,
              ),
              _ModuleCard(
                title: 'Seguros',
                icon: Icons.verified_user,
              ),
              _ModuleCard(
                title: 'Retiro',
                icon: Icons.account_balance,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // BLOQUE EXPERIENCIA
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Más de 15 años de experiencia',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Equipo de asesores certificados, reconocidos a nivel nacional, '
                  'acompañando decisiones financieras que cambian vidas.',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.dark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

        
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ModuleCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // navegación después
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: AppColors.primary),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
