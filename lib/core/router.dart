import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/shell.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/register/presentation/pages/register_data_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/seguros/home_page.dart';
import '../features/pensiones/home_page.dart';
import '../features/plan_retiro/home_page.dart';
import '../features/inversiones/home_page.dart';
import '../features/register/presentation/pages/select_verification_page.dart';
import '../features/register/presentation/pages/verification_page.dart';
import '../features/register/presentation/pages/password_page.dart';
import '../features/recover_pasword/presentation/pages/recover.dart';
import '../features/recover_pasword/presentation/pages/msj_success.dart';

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
  // ----- -----
  // REGISTER USER
  AppPageRoute(
    path: '/registro/preregistro',
    title: 'Registro',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) => const RegisterDataPage(),
  ),
  AppPageRoute(
    path: '/registro/select/verification',
    title: 'Seleciona Verificación',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return SelectverificationPage(userData: data);
    },
  ),
  AppPageRoute(
    path: '/registro/verification/code',
    title: 'Verifica tu código',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return VerificationPage(userData: data);
    },
  ),
  AppPageRoute(
    path: '/registro/create/password',
    title: 'Crea tu contraseña',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return CreatePasswordPage(userData: data);
    },
  ),
  // ----- -----
  // RECOVER PASSWORD
  AppPageRoute(
    path: '/recover/password',
    title: 'Recuperar contraseña',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) => const RecoverPasswordPage(),
  ),
  AppPageRoute(
    path: '/recover/success/msj',
    title: 'Mensaje enviado a tu correo',
    showAppBar: false,
    showBottomBar: false,
    builder: (context, state) => const SuccessMessagePage(),
  ),
  // ----- -----
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
