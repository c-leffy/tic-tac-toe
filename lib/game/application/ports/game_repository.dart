import 'package:tic_tac_toe/game/domain/model/game.dart';

abstract interface class GameRepository {
  Future<Game?> currentGame();

  Future<void> save(Game game);
}
