import 'dart:math';

import 'package:test/test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/domain/strategy/blocking_strategy.dart';

void main() {
  final strategy = BlockingStrategy();

  test(
    """Should block a row
┌───┬───┬───┐
│   │   │   │
├───┼───┼───┤
│   │ O │   │
├───┼───┼───┤
│ X │ X │ _ │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0, symbol: Symbol.x),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1),
        Cell(x: 1, y: 1, symbol: Symbol.o),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2),
        Cell(x: 1, y: 2),
        Cell(x: 2, y: 2),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 2, y: 0));
    },
  );

  test(
    """Should block a column
┌───┬───┬───┐
│ X │   │   │
├───┼───┼───┤
│ X │ O │   │
├───┼───┼───┤
│ _ │   │   │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0),
        Cell(x: 1, y: 0),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1, symbol: Symbol.x),
        Cell(x: 1, y: 1, symbol: Symbol.o),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2, symbol: Symbol.x),
        Cell(x: 1, y: 2),
        Cell(x: 2, y: 2),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 0, y: 0));
    },
  );

  test(
    """Should block the main diagonal
┌───┬───┬───┐
│   │   │ X │
├───┼───┼───┤
│   │ X │   │
├───┼───┼───┤
│ _ │ O │   │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0),
        Cell(x: 1, y: 0, symbol: Symbol.o),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1),
        Cell(x: 1, y: 1, symbol: Symbol.x),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2),
        Cell(x: 1, y: 2),
        Cell(x: 2, y: 2, symbol: Symbol.x),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 0, y: 0));
    },
  );

  test(
    """Should block the anti-diagonal
┌───┬───┬───┐
│ X │   │   │
├───┼───┼───┤
│ O │ X │   │
├───┼───┼───┤
│   │   │ _ │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0),
        Cell(x: 1, y: 0),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1, symbol: Symbol.o),
        Cell(x: 1, y: 1, symbol: Symbol.x),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2, symbol: Symbol.x),
        Cell(x: 1, y: 2),
        Cell(x: 2, y: 2),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 2, y: 0));
    },
  );

  test(
    """Should play randomly when no line has two player symbols
┌───┬───┬───┐
│ O │ X │ O │
├───┼───┼───┤
│ _ │ O │ X │
├───┼───┼───┤
│ X │   │ O │
└───┴───┴───┘
""",
    () {
      // given
      final strategy = BlockingStrategy(random: Random(0));
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0),
        Cell(x: 2, y: 0, symbol: Symbol.o),
        Cell(x: 0, y: 1),
        Cell(x: 1, y: 1, symbol: Symbol.o),
        Cell(x: 2, y: 1, symbol: Symbol.x),
        Cell(x: 0, y: 2, symbol: Symbol.o),
        Cell(x: 1, y: 2, symbol: Symbol.x),
        Cell(x: 2, y: 2, symbol: Symbol.o),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 0, y: 1));
    },
  );
}
