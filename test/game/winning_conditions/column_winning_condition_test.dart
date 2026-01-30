import 'package:test/test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';

import '../builder/game_builder.dart';

void main() {
  group("With full column with only one symbol, round should be win", () {
    test(
      """
┌───┬───┬───┐
│ X │   │   │
├───┼───┼───┤
│ X │   │   │
├───┼───┼───┤
│ X │   │   │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .x),
          Cell(x: 0, y: 1, symbol: .x),
          Cell(x: 0, y: 2, symbol: .x),
          Cell(x: 1, y: 0, symbol: .empty),
          Cell(x: 1, y: 1, symbol: .empty),
          Cell(x: 1, y: 2, symbol: .empty),
          Cell(x: 2, y: 0, symbol: .empty),
          Cell(x: 2, y: 1, symbol: .empty),
          Cell(x: 2, y: 2, symbol: .empty),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isTrue);
      },
    );

    test(
      """
┌───┬───┬───┐
│   │ O │   │
├───┼───┼───┤
│   │ O │   │
├───┼───┼───┤
│   │ 0 │   │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .empty),
          Cell(x: 0, y: 1, symbol: .empty),
          Cell(x: 0, y: 2, symbol: .empty),
          Cell(x: 1, y: 0, symbol: .o),
          Cell(x: 1, y: 1, symbol: .o),
          Cell(x: 1, y: 2, symbol: .o),
          Cell(x: 2, y: 0, symbol: .empty),
          Cell(x: 2, y: 1, symbol: .empty),
          Cell(x: 2, y: 2, symbol: .empty),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isTrue);
      },
    );

    test(
      """
┌───┬───┬───┐
│   │   │ X │
├───┼───┼───┤
│   │   │ X │
├───┼───┼───┤
│   │   │ X │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .empty),
          Cell(x: 0, y: 1, symbol: .empty),
          Cell(x: 0, y: 2, symbol: .empty),
          Cell(x: 1, y: 0, symbol: .empty),
          Cell(x: 1, y: 1, symbol: .empty),
          Cell(x: 1, y: 2, symbol: .empty),
          Cell(x: 2, y: 0, symbol: .x),
          Cell(x: 2, y: 1, symbol: .x),
          Cell(x: 2, y: 2, symbol: .x),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isTrue);
      },
    );
  });

  group("With full column with different symbol, round should not be win", () {
    test(
      """
┌───┬───┬───┐
│ X │   │   │
├───┼───┼───┤
│ O │   │   │
├───┼───┼───┤
│ X │   │   │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .x),
          Cell(x: 0, y: 1, symbol: .o),
          Cell(x: 0, y: 2, symbol: .x),
          Cell(x: 1, y: 0, symbol: .empty),
          Cell(x: 1, y: 1, symbol: .empty),
          Cell(x: 1, y: 2, symbol: .empty),
          Cell(x: 2, y: 0, symbol: .empty),
          Cell(x: 2, y: 1, symbol: .empty),
          Cell(x: 2, y: 2, symbol: .empty),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isFalse);
      },
    );

    test(
      """
┌───┬───┬───┐
│   │ O │   │
├───┼───┼───┤
│   │ O │   │
├───┼───┼───┤
│   │ X │   │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .empty),
          Cell(x: 0, y: 1, symbol: .empty),
          Cell(x: 0, y: 2, symbol: .empty),
          Cell(x: 1, y: 0, symbol: .o),
          Cell(x: 1, y: 1, symbol: .o),
          Cell(x: 1, y: 2, symbol: .x),
          Cell(x: 2, y: 0, symbol: .empty),
          Cell(x: 2, y: 1, symbol: .empty),
          Cell(x: 2, y: 2, symbol: .empty),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isFalse);
      },
    );

    test(
      """
┌───┬───┬───┐
│   │   │ O │
├───┼───┼───┤
│   │   │ X │
├───┼───┼───┤
│   │   │ X │
└───┴───┴───┘
    """,
      () {
        // given
        final board = Board([
          Cell(x: 0, y: 0, symbol: .empty),
          Cell(x: 0, y: 1, symbol: .empty),
          Cell(x: 0, y: 2, symbol: .empty),
          Cell(x: 1, y: 0, symbol: .empty),
          Cell(x: 1, y: 1, symbol: .empty),
          Cell(x: 1, y: 2, symbol: .empty),
          Cell(x: 2, y: 0, symbol: .o),
          Cell(x: 2, y: 1, symbol: .x),
          Cell(x: 2, y: 2, symbol: .x),
        ]);
        final game = aGame().board(board).build();

        // when
        final hasWinner = game.hasWinner();

        // then
        expect(hasWinner, isFalse);
      },
    );
  });
}
