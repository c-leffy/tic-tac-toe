import 'package:test/test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/domain/strategy/minimax_strategy.dart';

void main() {
  final strategy = MinimaxStrategy();

  test(
    """Should win when possible in one move
┌───┬───┬───┐
│ O │   │   │
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
        Cell(x: 0, y: 2, symbol: Symbol.o),
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
    """Should block player from winning
┌───┬───┬───┐
│ O │   │   │
├───┼───┼───┤
│   │   │   │
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
        Cell(x: 1, y: 1),
        Cell(x: 2, y: 1),
        Cell(x: 0, y: 2, symbol: Symbol.o),
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
    """Should find the only winning move
┌───┬───┬───┐
│ _ │ X │ O │
├───┼───┼───┤
│   │ O │ X │
├───┼───┼───┤
│ X │   │ O │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0),
        Cell(x: 2, y: 0, symbol: Symbol.o),
        Cell(x: 0, y: 1),
        Cell(x: 1, y: 1, symbol: Symbol.o),
        Cell(x: 2, y: 1, symbol: Symbol.x),
        Cell(x: 0, y: 2),
        Cell(x: 1, y: 2, symbol: Symbol.x),
        Cell(x: 2, y: 2, symbol: Symbol.o),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 0, y: 2));
    },
  );

  test(
    """Should win on last remaining cell
┌───┬───┬───┐
│ O │ X │ X │
├───┼───┼───┤
│ X │ O │ O │
├───┼───┼───┤
│ X │ O │ _ │
└───┴───┴───┘
""",
    () {
      // given
      final board = Board([
        Cell(x: 0, y: 0, symbol: Symbol.x),
        Cell(x: 1, y: 0, symbol: Symbol.o),
        Cell(x: 2, y: 0),
        Cell(x: 0, y: 1, symbol: Symbol.x),
        Cell(x: 1, y: 1, symbol: Symbol.o),
        Cell(x: 2, y: 1, symbol: Symbol.o),
        Cell(x: 0, y: 2, symbol: Symbol.o),
        Cell(x: 1, y: 2, symbol: Symbol.x),
        Cell(x: 2, y: 2, symbol: Symbol.x),
      ]);

      // when
      final cell = strategy.chooseCell(board);

      // then
      expect(cell, const Cell(x: 2, y: 0));
    },
  );
}
