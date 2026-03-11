import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      title: Text(title),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
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