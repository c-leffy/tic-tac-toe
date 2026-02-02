import 'dart:math';

import 'package:test/test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/domain/strategy/random_strategy.dart';

void main() {
  test(
    """Should choose a random empty cell
┌───┬───┬───┐
│   │   │   │
├───┼───┼───┤
│ _ │ X │   │
├───┼───┼───┤
│ X │ O │   │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0, symbol: Symbol.o),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1),
        Cell(x: 1, y: 1, symbol: Symbol.x),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2),
        Cell(x: 1, y: 2),
        Cell(x: 2, y: 2),
      ]);
      final strategy = RandomStrategy(random: Random(42));

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 0, y: 1));
    },
  );

  test(
    """Should choose the only empty cell when one remains
┌───┬───┬───┐
│ O │ X │ _ │
├───┼───┼───┤
│ O │ X │ O │
├───┼───┼───┤
│ X │ O │ X │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0, symbol: Symbol.o),
        Cell(x: 2, y: 0, symbol: Symbol.x),
        Cell(x: 0, y: 1, symbol: Symbol.o),
        Cell(x: 1, y: 1, symbol: Symbol.x),
        Cell(x: 2, y: 1, symbol: Symbol.o),
        Cell(x: 0, y: 2, symbol: Symbol.o),
        Cell(x: 1, y: 2, symbol: Symbol.x),
        Cell(x: 2, y: 2),
      ]);
      final strategy = RandomStrategy();

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 2, y: 2));
    },
  );
}
