import 'package:flutter/material.dart';
import 'package:joli/core/theme/app_colors.dart';
// import '../theme/app_colors.dart';
import '../utils/ui_helpers.dart';

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
  const JoliBottomNav({super.key, required this.location});

  final String location;

  int _selectedIndex() {
    final idx = _navItems.indexWhere((item) => item.path == location);
    return idx >= 0 ? idx : 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      indicatorColor: AppColors.primary,
      selectedIndex: _selectedIndex(),
      onDestinationSelected: (i) {
        final path = _navItems[i].path;
        if (path != location) {
          go(context, path);
        }
      },
      destinations: [
        for (final item in _navItems)
          NavigationDestination(icon: Icon(item.icon), label: item.label),
      ],
    );
  }
}
