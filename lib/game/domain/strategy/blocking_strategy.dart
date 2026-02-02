import 'dart:math';

import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/domain/strategy/ia_strategy.dart';
import 'package:tic_tac_toe/game/domain/strategy/random_strategy.dart';

/// IA strategy that focuses on blocking the player.
///
/// Scans every row, column and diagonal for a line where the player
/// ([Symbol.x]) is one move away from winning (2× [Symbol.x] + 1 empty
/// cell) and plays that empty cell to block.
///
/// When no immediate threat is found, falls back to [RandomStrategy].
class BlockingStrategy implements IaStrategy {
  final RandomStrategy _fallback;

  BlockingStrategy({Random? random}) : _fallback = RandomStrategy(random: random);

  @override
  Cell chooseCell(Board board) {
    final lines = [...board.rows, ...board.columns, ...board.diagonals];

    final blockingCell = _findCriticalCell(lines);
    if (blockingCell != null) return blockingCell;

    return _fallback.chooseCell(board);
  }

  Cell? _findCriticalCell(Iterable<Iterable<Cell>> lines) {
    return lines
        .where((line) => line.where((c) => c.symbol == Symbol.x).length == 2)
        .where((line) => line.where((c) => c.symbol == Symbol.empty).length == 1)
        .map((line) => line.firstWhere((c) => c.symbol == Symbol.empty))
        .firstOrNull;
  }
}
