import 'package:game/domain/exception/game_over_exception.dart';
import 'package:game/domain/model/game.dart';

class PlayerWonGame extends Game {
  const PlayerWonGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw GameOverException();
  }
}
