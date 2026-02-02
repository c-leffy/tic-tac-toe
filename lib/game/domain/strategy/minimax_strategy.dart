import 'dart:math';

import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/domain/model/winning_condition.dart';
import 'package:tic_tac_toe/game/domain/strategy/ia_strategy.dart';

/// IA strategy that plays optimally using the Minimax algorithm.
///
/// Minimax is a decision-making algorithm for two-player zero-sum games.
/// It explores every possible game state recursively and assigns a score
/// to each outcome:
///
/// - **+1** — IA wins
/// - **-1** — Player wins
/// - **0** — Draw
///
/// The IA (maximizing player, [Symbol.o]) picks the move with the
/// highest score, while the opponent (minimizing player, [Symbol.x])
/// is assumed to pick the move with the lowest score. By simulating
/// both sides playing optimally, the algorithm guarantees the best
/// possible outcome for the IA.
///
/// On a 3×3 board the search space is small enough (≤ 9! nodes) for
/// a brute-force exploration without pruning.
class MinimaxStrategy implements IaStrategy {
  static const _iaSymbol = Symbol.o;
  static const _winningCondition = WinningCondition();

  /// Returns the [Cell] that leads to the best outcome for the IA.
  ///
  /// Evaluates every empty cell on the [board] and keeps the one
  /// with the highest minimax score.
  @override
  Cell chooseCell(Board board) {
    return board.emptyCells.reduce((bestCell, cell) {
      final score = _evaluate(board, cell, _iaSymbol);
      final bestScore = _evaluate(board, bestCell, _iaSymbol);
      return score > bestScore ? cell : bestCell;
    });
  }

  /// Simulates placing [symbol] on [cell] and returns the minimax
  /// score of the resulting board from the opponent's perspective.
  int _evaluate(Board board, Cell cell, Symbol symbol) {
    final newBoard = board.playAt(cell.x, cell.y, symbol);
    final opponent = symbol == _iaSymbol ? Symbol.x : Symbol.o;
    return _minimax(newBoard, opponent);
  }

  /// Recursively scores the [board] for the player identified by
  /// [symbol].
  ///
  /// Terminal conditions:
  /// - A winner exists → **+1** if the last move favoured the IA,
  ///   **-1** otherwise.
  /// - The board is full with no winner → **0** (draw).
  ///
  /// The IA ([Symbol.o]) maximises its score while the player
  /// ([Symbol.x]) minimises it.
  int _minimax(Board board, Symbol symbol) {
    if (_winningCondition.hasWinner(board)) return symbol == _iaSymbol ? -1 : 1;
    if (board.isFull()) return 0;

    final scores = board.emptyCells.map((cell) => _evaluate(board, cell, symbol));

    return symbol == _iaSymbol ? scores.reduce(max) : scores.reduce(min);
  }
}
