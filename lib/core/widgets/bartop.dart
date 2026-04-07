// import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class JoliAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JoliAppBar({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.joli,
      elevation: 0,
      surfaceTintColor: AppColors.background,
      title: Row(
        children: [
          // Título dinámico
          if (location.trim().isNotEmpty) ...[
            const SizedBox(width: 5),
            Text(
              location,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
          },
          icon: const Icon(Icons.support_agent),
          color: Colors.white,
          tooltip: 'Asesoría',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu),
            color: const Color.fromARGB(255, 255, 255, 255),
            tooltip: 'Menú',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
