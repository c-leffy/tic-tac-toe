import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/player.dart';

GameBuilder aGame() => GameBuilder();

class GameBuilder {
  Difficulty _difficulty = .easy;
  Board _board = Board.generate3x3();
  Player _player = Player.player("Guest");
  final Player _ia = Player.ia();

  GameBuilder difficulty(Difficulty difficulty) {
    _difficulty = difficulty;
    return this;
  }

  GameBuilder board(Board board) {
    _board = board;
    return this;
  }

  GameBuilder player(Player player) {
    _player = player;
    return this;
  }

  Game build() => Game(board: _board, player: _player, ia: _ia, difficulty: _difficulty);
}
