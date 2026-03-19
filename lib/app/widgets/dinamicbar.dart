import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';

class AppBarGlobal extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final List<Widget>? actions;
  final bool centerTitle;

  const AppBarGlobal({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {

    final canGoBack = GoRouter.of(context).canPop();

    return AppBar(
      elevation: 0,
      backgroundColor:  AppColors.joli,
      title: Text(title),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      centerTitle: centerTitle,

      leading: canGoBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            )
          : null,

      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}