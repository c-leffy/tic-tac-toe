import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

class WinningCondition {
  const WinningCondition();

  bool hasWinner(Board board) {
    final lines = [...board.rows, ...board.columns, ...board.diagonals];
    return lines.any(_isComplete);
  }

  bool _isComplete(Iterable<Cell> cells) =>
      cells.every((cell) => cell.symbol != Symbol.empty) &&
      cells.every((cell) => cell.symbol == cells.first.symbol);
}
