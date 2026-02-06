import 'package:go_router/go_router.dart';
import 'package:game/game.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: "/game",
      builder: (context, state) => const GamePage(),
    ),
  ],
);
