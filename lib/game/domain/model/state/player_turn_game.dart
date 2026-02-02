import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/draw_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/ia_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_won_game.dart';
import 'package:tic_tac_toe/game/domain/model/winning_condition.dart';

class PlayerTurnGame extends Game {
  const PlayerTurnGame({required super.board, super.difficulty});

  @override
  Game playAt({required int x, required int y}) {
    final updatedBoard = board.playAt(x, y, .x);

    if (const WinningCondition().hasWinner(updatedBoard)) {
      return PlayerWonGame(board: updatedBoard, difficulty: difficulty);
    }

    if (updatedBoard.isFull()) {
      return DrawGame(board: updatedBoard, difficulty: difficulty);
    }

    return IaTurnGame(board: updatedBoard, difficulty: difficulty);
  }
}
