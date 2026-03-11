import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import '../app/widgets/bartop.dart';
import '../app/widgets/barbottom.dart';
import '../app/widgets/side_menu.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({
    super.key,
    required this.child,
    required this.location,
    required this.title,
    required this.showAppBar,
    required this.showBottomBar,
  });

  final Widget child;
  final String location;
  final String title;
  final bool showAppBar;
  final bool showBottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? JoliAppBar(location: title) : null,

      // Drawer
      endDrawer: const JoliSideMenu(),

      backgroundColor: AppColors.background,
      body: child,

      // BottomNav
      bottomNavigationBar: showBottomBar
          ? JoliBottomNav(
              location: location,
            )
          : null,
    );
  }
}