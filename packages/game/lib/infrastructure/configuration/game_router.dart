import 'package:game/presentation/view/game_page.dart';
import 'package:game/presentation/view/home_page.dart';
import 'package:go_router/go_router.dart';

final gameRoutes = [
  GoRoute(path: GameRoutes.home.path, builder: (context, state) => const HomePage()),
  GoRoute(path: GameRoutes.game.path, builder: (context, state) => const GamePage()),
];

enum GameRoutes {
  home("/"),
  game("/game");

  const GameRoutes(this.path);

  final String path;
}
