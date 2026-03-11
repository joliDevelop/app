import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/shell.dart';

import '../features/auth/login_page.dart';
import '../features/register/data.dart';
import '../features/home/home_page.dart';
import '../features/seguros/home_page.dart';
import '../features/pensiones/home_page.dart';
import '../features/plan_retiro/home_page.dart';
import '../features/inversiones/home_page.dart';

class AppPageRoute {
  const AppPageRoute({
    required this.path,
    required this.title,
    required this.builder,
    this.showAppBar = true,
    this.showBottomBar = true,
  });

  final String path;
  final String title;
  final Widget Function(BuildContext, GoRouterState) builder;

  final bool showAppBar;
  final bool showBottomBar;
}

final appPages = <AppPageRoute>[
  AppPageRoute(
    path: '/login',
    title: 'Login',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) => const LoginPage(),
  ),
  AppPageRoute(
    path: '/registro',
    title: 'Registro',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) => const RegisterDataPage(),
  ),
  AppPageRoute(
    path: '/home',
    title: 'Home',
    showAppBar: true,
    showBottomBar: true,
    builder: (context, state) => const HomePage(),
  ),
  AppPageRoute(
    path: '/seguros/home',
    title: 'Seguros',
    showAppBar: true,
    showBottomBar: true,
    builder: (context, state) => const HomeSegurosPage(),
  ),
  AppPageRoute(
    path: '/pensiones/home',
    title: 'Pensiones',
    showAppBar: true,
    showBottomBar: true,
    builder: (context, state) => const HomePensionesPage(),
  ),
  AppPageRoute(
    path: '/retiro/home',
    title: 'Plan de Retiro',
    showAppBar: true,
    showBottomBar: true,
    builder: (context, state) => const HomePlanRetiro(),
  ),
  AppPageRoute(
    path: '/inversiones/home',
    title: 'Inversiones',
    showAppBar: true,
    showBottomBar: true,
    builder: (context, state) => const HomeInversiones(),
  ),
];

AppPageRoute _pageForPath(String path) {
  return appPages.firstWhere(
    (p) => p.path == path,
    orElse: () => const AppPageRoute(
      path: '',
      title: '',
      showAppBar: true,
      showBottomBar: true,
      builder: _emptyBuilder,
    ),
  );
}

// builder dummy para el "orElse" const
Widget _emptyBuilder(BuildContext context, GoRouterState state) =>
    const SizedBox.shrink();

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/home'),

    ShellRoute(
      builder: (context, state, child) {
        final path = state.uri.path;
        final page = _pageForPath(path);

        return HomeShell(
          location: path,
          title: page.title,
          showAppBar: page.showAppBar,
          showBottomBar: page.showBottomBar,
          child: child,
        );
      },
      routes: [
        for (final p in appPages) GoRoute(path: p.path, builder: p.builder),
      ],
    ),
  ],
);
