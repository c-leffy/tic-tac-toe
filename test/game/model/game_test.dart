import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tic_tac_toe/game/domain/exception/game_over_exception.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/state/draw_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/ia_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_won_game.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

import '../builder/game_builder.dart';

void main() {
  group("After player's turn", () {
    test("and no winning condition, should be IA's turn", () {
      // given
      final game = aGame().build();

      // when
      final updatedGame = game.playAt(x: 0, y: 0);

      // then
      expect(updatedGame, isA<IaTurnGame>());
    });

    test("and a winning condition, should be a win", () {
      // given
      // ┌───┬───┬───┐
      // │ X │ X │ _ │
      // └───┴───┴───┘
      final game = aGame()
          .board(Board([Cell(x: 0, y: 0, symbol: .x), Cell(x: 1, y: 0, symbol: .x), Cell(x: 2, y: 0, symbol: .empty)]))
          .build();

      // when
      final updatedGame = game.playAt(x: 2, y: 0);

      // then
      expect(updatedGame, isA<PlayerWonGame>());
    });

    test('and no winning condition and a full board, should be a draw', () {
      // given
      // ┌───┬───┬───┐
      // │ O │ X │ _ │
      // ├───┼───┼───┤
      // │ X │ O │ O │
      // ├───┼───┼───┤
      // │ X │ O │ X │
      // └───┴───┴───┘
      final game = aGame()
          .board(
            Board([
              Cell(x: 0, y: 0, symbol: .x),
              Cell(x: 1, y: 0, symbol: .o),
              Cell(x: 2, y: 0, symbol: .x),
              Cell(x: 0, y: 1, symbol: .x),
              Cell(x: 1, y: 1, symbol: .o),
              Cell(x: 2, y: 1, symbol: .o),
              Cell(x: 0, y: 2, symbol: .o),
              Cell(x: 1, y: 2, symbol: .x),
              Cell(x: 2, y: 2, symbol: .empty),
            ]),
          )
          .build();

      // when
      final updatedGame = game.playAt(x: 2, y: 2);

      // then
      expect(updatedGame, isA<DrawGame>());
    });
  });

  test("After IA's turn and no winning condition, should be player's turn", () {
    // given
    final game = aGame().buildIaTurn();

    // when
    final updatedGame = game.playAt(x: 0, y: 0);

    // then
    expect(updatedGame, isA<PlayerTurnGame>());
    expect(updatedGame.board.rows.first.first.symbol, Symbol.o);
  });

  test("Can't play if game is already won by IA", () {
    // given
    final game = aGame().buildIaWon();

    // then
    expect(() => game.playAt(x: 0, y: 0), throwsA(isA<GameOverException>()));
  });

  test("Can't play if game is already won by player", () {
    // given
    final game = aGame().buildPlayerWon();

    // then
    expect(() => game.playAt(x: 0, y: 0), throwsA(isA<GameOverException>()));
  });

  test("Can't play if game is already a draw", () {
    // given
    final game = aGame().buildDraw();

    // then
    expect(() => game.playAt(x: 0, y: 0), throwsA(isA<GameOverException>()));
  });
}
