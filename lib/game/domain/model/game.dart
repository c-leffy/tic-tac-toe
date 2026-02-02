import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game/domain/exception/game_over_exception.dart';
import 'package:tic_tac_toe/game/domain/exception/not_player_turn_exception.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

sealed class Game extends Equatable {
  final Difficulty difficulty;
  final Board board;

  const Game({required this.board, this.difficulty = Difficulty.easy});

  Game playAt({required int x, required int y});

  @override
  List<Object?> get props => [difficulty, board];
}

class PlayerTurnGame extends Game {
  const PlayerTurnGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    final updatedBoard = board.playAt(x, y, .x);

    if (_hasWinner(updatedBoard)) {
      return HasWinnerGame(board: updatedBoard, difficulty: difficulty);
    }

    if (updatedBoard.isFull()) {
      return DrawGame(board: updatedBoard, difficulty: difficulty);
    }

    return IaTurnGame(board: updatedBoard, difficulty: difficulty);
  }

  bool _hasWinner(Board board) {
    final lines = [...board.rows, ...board.columns, ...board.diagonals];
    return lines.any(_isComplete);
  }

  bool _isComplete(Iterable<Cell> cells) =>
      cells.every((cell) => cell.symbol != Symbol.empty) &&
      cells.every((cell) => cell.symbol == cells.first.symbol);
}

class IaTurnGame extends Game {
  const IaTurnGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw NotPlayerTurnException();
  }
}

class HasWinnerGame extends Game {
  const HasWinnerGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw GameOverException();
  }
}

class DrawGame extends Game {
  const DrawGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    throw GameOverException();
  }
}
