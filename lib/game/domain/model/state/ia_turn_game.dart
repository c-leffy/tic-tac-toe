import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/draw_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/has_winner_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/winning_condition.dart';

class IaTurnGame extends Game {
  const IaTurnGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    final updatedBoard = board.playAt(x, y, .o);

    if (const WinningCondition().hasWinner(updatedBoard)) {
      return HasWinnerGame(board: updatedBoard, difficulty: difficulty);
    }

    if (updatedBoard.isFull()) {
      return DrawGame(board: updatedBoard, difficulty: difficulty);
    }

    return PlayerTurnGame(board: updatedBoard, difficulty: difficulty);
  }
}
