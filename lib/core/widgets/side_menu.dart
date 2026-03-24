import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/ui_helpers.dart';
import '../providers/sesion_provider.dart';
//  con utilidades para acceder a estados globales.
import 'package:provider/provider.dart';

class JoliSideMenu extends StatelessWidget {
  const JoliSideMenu({super.key, this.onNavigate});

  final ValueChanged<String>? onNavigate;

  @override
  Widget build(BuildContext context) {
    final isLogged = context.watch<SesionProvider>().isLogged;

    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, color: AppColors.navy),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Sebastian',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.border),

            // Items
            _MenuItem(
              icon: Icons.home_outlined,
              title: 'Inicio',
              onTap: () {
                Navigator.pop(context);
                go(context, '/home');
              },
            ),
            _MenuItem(
              icon: Icons.shield_outlined,
              title: 'Seguros',
              onTap: () {
                Navigator.pop(context);
                go(context, '/seguros/home');
              },
            ),
            _MenuItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Pensiones',
              onTap: () {
                Navigator.pop(context);
                go(context, '/pensiones/home');
              },
            ),
            _MenuItem(
              icon: Icons.trending_up,
              title: 'Inversión',
              onTap: () {
                Navigator.pop(context);
                go(context, '/inversiones/home');
              },
            ),
            _MenuItem(
              icon: Icons.account_balance_outlined,
              title: 'Plan de retiro',
              onTap: () {
                Navigator.pop(context);
                go(context, '/retiro/home');
              },
            ),

            const Spacer(),

            const Divider(height: 1, color: AppColors.border),

            if (!isLogged) ...[
              _MenuItem(
                icon: Icons.logout,
                title: 'Iniciar sesión',
                danger: true,
                onTap: () {
                  Navigator.pop(context);
                  go(context, '/login');
                },
              ),

              const SizedBox(height: 10),
            ] else ...[
              _MenuItem(
                icon: Icons.logout,
                title: 'Cerrar sesión',
                danger: true,
                
                onTap: () async {
                  final confirm = await showConfirmDialog(
                    context,
                    title: 'Cerrar sesión',
                    message: '¿Seguro que deseas cerrar sesión?',
                    confirmText: 'Cerrar sesión',
                  );

                  if (!confirm) return;

                  await context.read<SesionProvider>().logout();
                  Navigator.pop(context);
                  go(context, '/home');
                },
              ),

              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red.shade600 : AppColors.navy;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
