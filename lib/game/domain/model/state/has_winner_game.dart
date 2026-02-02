import 'package:tic_tac_toe/game/domain/exception/game_over_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';

class HasWinnerGame extends Game {
  const HasWinnerGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw GameOverException();
  }
}
