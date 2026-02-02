import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/draw_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/ia_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/ia_won_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_won_game.dart';

GameBuilder aGame() => GameBuilder();

class GameBuilder {
  Difficulty _difficulty = Difficulty.easy;
  Board _board = Board.generate3x3();

  GameBuilder difficulty(Difficulty difficulty) {
    _difficulty = difficulty;
    return this;
  }

  GameBuilder board(Board board) {
    _board = board;
    return this;
  }

  Game build() => PlayerTurnGame(board: _board, difficulty: _difficulty);

  Game buildPlayerWon() => PlayerWonGame(board: _board, difficulty: _difficulty);

  Game buildIaTurn() => IaTurnGame(board: _board, difficulty: _difficulty);

  Game buildIaWon() => IaWonGame(board: _board, difficulty: _difficulty);

  Game buildDraw() => DrawGame(board: _board, difficulty: _difficulty);
}
