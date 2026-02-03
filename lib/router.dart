import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/game/presentation/view/game_page.dart';
import 'package:tic_tac_toe/game/presentation/view/home_page.dart';

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
