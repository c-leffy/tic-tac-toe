import 'package:game/domain/exception/game_over_exception.dart';
import 'package:game/domain/model/game.dart';

class IaWonGame extends Game {
  const IaWonGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw GameOverException();
  }
}
