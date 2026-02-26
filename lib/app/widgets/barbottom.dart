import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class _NavItem {
  const _NavItem({required this.path, required this.label, required this.icon});

  final String path;
  final String label;
  final IconData icon;
}

const _navItems = <_NavItem>[
  _NavItem(path: '/home', label: 'Home', icon: Icons.home_outlined),
  _NavItem(
    path: '/seguros/home',
    label: 'Seguros',
    icon: Icons.shield_outlined,
  ),
  _NavItem(
    path: '/pensiones/home',
    label: 'Pensiones',
    icon: Icons.account_balance_wallet_outlined,
  ),
  _NavItem(
    path: '/inversiones/home',
    label: 'Inversión',
    icon: Icons.trending_up,
  ),
  _NavItem(
    path: '/retiro/home',
    label: 'Retiro',
    icon: Icons.account_balance_outlined,
  ),
];

class JoliBottomNav extends StatelessWidget {
  const JoliBottomNav({
    super.key,
    required this.location,
    required this.onNavigate,
  });

  final String location;
  final ValueChanged<String> onNavigate;

  int _selectedIndex() {
    final idx = _navItems.indexWhere((item) => item.path == location);
    return idx >= 0 ? idx : 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: AppColors.background,
        indicatorColor: AppColors.navy.withOpacity(0.15),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
            );
          }
          return const TextStyle(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w400,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: AppColors.navy, size: 26);
          }
          return const IconThemeData(color: AppColors.textMuted, size: 24);
        }),
      ),
      child: NavigationBar(
        height: 70,
        elevation: 0,
        selectedIndex: _selectedIndex(),
        onDestinationSelected: (i) => onNavigate(_navItems[i].path),
        destinations: [
          for (final item in _navItems)
            NavigationDestination(icon: Icon(item.icon), label: item.label),
        ],
      ),
    );
  }
}
