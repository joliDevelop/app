import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/bartop.dart';
import '../core/widgets/barbottom.dart';
import '../core/widgets/side_menu.dart';
import '../core/services/loading_service.dart';

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
      
      body: Stack(
        children: [
          child,

          ValueListenableBuilder<bool>(
            valueListenable: LoadingService.isLoading,
            builder: (context, isLoading, _) {
              if (!isLoading) return const SizedBox();

              return Container(
                color: const Color.fromARGB(20, 225, 225, 225).withOpacity(0.4),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),

      // BottomNav
      bottomNavigationBar: showBottomBar
          ? JoliBottomNav(location: location)
          : null,
    );
  }
}
