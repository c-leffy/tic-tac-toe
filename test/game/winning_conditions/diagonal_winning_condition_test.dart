import 'package:test/test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';

import '../builder/game_builder.dart';

void main() {
  group("With full diagonal with only one symbol, round should be win", () {
    test(
      """
┌───┬───┬───┐
│ _ │   │   │
├───┼───┼───┤
│   │ X │   │
├───┼───┼───┤
│   │   │ X │
└───┴───┴───┘
    """,
      () {
        // given
        final game = aGame()
            .board(
              Board([
                Cell(x: 0, y: 0, symbol: .empty),
                Cell(x: 1, y: 0, symbol: .empty),
                Cell(x: 2, y: 0, symbol: .x),
                Cell(x: 0, y: 1, symbol: .empty),
                Cell(x: 1, y: 1, symbol: .x),
                Cell(x: 2, y: 1, symbol: .empty),
                Cell(x: 0, y: 2, symbol: .empty),
                Cell(x: 1, y: 2, symbol: .empty),
                Cell(x: 2, y: 2, symbol: .empty),
              ]),
            )
            .build();

        // when
        final updatedGame = game.playAt(x: 0, y: 2);

        // then
        expect(updatedGame, isA<HasWinnerGame>());
      },
    );

    test(
      """
┌───┬───┬───┐
│   │   │ _ │
├───┼───┼───┤
│   │ X │   │
├───┼───┼───┤
│ X │   │   │
└───┴───┴───┘
    """,
      () {
        // given
        final game = aGame()
            .board(
              Board([
                Cell(x: 0, y: 0, symbol: .x),
                Cell(x: 1, y: 0, symbol: .empty),
                Cell(x: 2, y: 0, symbol: .empty),
                Cell(x: 0, y: 1, symbol: .empty),
                Cell(x: 1, y: 1, symbol: .x),
                Cell(x: 2, y: 1, symbol: .empty),
                Cell(x: 0, y: 2, symbol: .empty),
                Cell(x: 1, y: 2, symbol: .empty),
                Cell(x: 2, y: 2, symbol: .empty),
              ]),
            )
            .build();

        // when
        final updatedGame = game.playAt(x: 2, y: 2);

        // then
        expect(updatedGame, isA<HasWinnerGame>());
      },
    );
  });

  group("With a full diagonal with different symbol, round should not be win", () {
    test(
      """
┌───┬───┬───┐
│ X │   │   │
├───┼───┼───┤
│   │ _ │   │
├───┼───┼───┤
│   │   │ O │
└───┴───┴───┘
    """,
      () {
        // given
        final game = aGame()
            .board(
              Board([
                Cell(x: 0, y: 0, symbol: .empty),
                Cell(x: 1, y: 0, symbol: .empty),
                Cell(x: 2, y: 0, symbol: .o),
                Cell(x: 0, y: 1, symbol: .empty),
                Cell(x: 1, y: 1, symbol: .empty),
                Cell(x: 2, y: 1, symbol: .empty),
                Cell(x: 0, y: 2, symbol: .x),
                Cell(x: 1, y: 2, symbol: .empty),
                Cell(x: 2, y: 2, symbol: .empty),
              ]),
            )
            .build();

        // when
        final updatedGame = game.playAt(x: 1, y: 1);

        // then
        expect(updatedGame, isA<IaTurnGame>());
      },
    );

    test(
      """
┌───┬───┬───┐
│   │   │ O │
├───┼───┼───┤
│   │ O │   │
├───┼───┼───┤
│ _ │   │   │
└───┴───┴───┘
    """,
      () {
        // given
        final game = aGame()
            .board(
              Board([
                Cell(x: 0, y: 0, symbol: .empty),
                Cell(x: 1, y: 0, symbol: .empty),
                Cell(x: 2, y: 0, symbol: .empty),
                Cell(x: 0, y: 1, symbol: .empty),
                Cell(x: 1, y: 1, symbol: .o),
                Cell(x: 2, y: 1, symbol: .empty),
                Cell(x: 0, y: 2, symbol: .empty),
                Cell(x: 1, y: 2, symbol: .empty),
                Cell(x: 2, y: 2, symbol: .o),
              ]),
            )
            .build();

        // when
        final updatedGame = game.playAt(x: 0, y: 0);

        // then
        expect(updatedGame, isA<IaTurnGame>());
      },
    );
  });
}
