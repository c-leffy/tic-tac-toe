import 'package:game/domain/model/game.dart';

abstract interface class GameRepository {
  Future<Game?> currentGame();

  Future<void> save(Game game);
}
