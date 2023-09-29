import 'package:go_router/go_router.dart';
import 'package:horario/screens/home.dart';
import 'package:horario/screens/agregar_horario.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/home',
      name: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/agregar',
      name: '/agregar',
      builder: (context, state) => const AgregarScreen(),
    )
  ],
);