import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:game/game.dart';
import 'package:analytics/analytics.dart';

import '../builder/game_builder.dart';

PlayGame createPlayGame(GameRepository gameRepository) => PlayGame(gameRepository, const NoAnalytics());

void main() {
  test("Can't play if there is no game", () async {
    // given
    final GameRepository gameRepository = InMemoryGameRepository();
    final playGame = createPlayGame(gameRepository);

    // then
    expect(() async {
      // when
      await playGame.execute(PlayGameCommand(x: 0, y: 0));
    }, throwsA(isA<NoGameStartedException>()));
  });

  test("Can't play if this is not the player's turn", () async {
    // given
    final game = aGame().buildIaTurn();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playGame = createPlayGame(gameRepository);

    // then
    expect(() async {
      // when
      await playGame.execute(PlayGameCommand(x: 0, y: 0));
    }, throwsA(isA<NotPlayerTurnException>()));
  });

  test("Can't play on a cell with a symbol (X or O)", () async {
    // given
    final game = aGame()
        .board(
          Board([
            Cell(x: 0, y: 0, symbol: .x),
            Cell(x: 1, y: 0, symbol: .o),
            Cell(x: 2, y: 0, symbol: .empty),
            Cell(x: 0, y: 1, symbol: .empty),
          ]),
        ) //
        .build();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playGame = createPlayGame(gameRepository);

    // then
    expect(() async {
      // when
      await playGame.execute(PlayGameCommand(x: 0, y: 0));
    }, throwsA(isA<CellNotAvailableException>()));
    expect(() async {
      // when
      await playGame.execute(PlayGameCommand(x: 1, y: 0));
    }, throwsA(isA<CellNotAvailableException>()));
  });

  test("Can't play on a cell that doesn't exist", () async {
    // given
    final game = aGame()
        .board(
          Board([
            Cell(x: 0, y: 0, symbol: .empty),
            Cell(x: 1, y: 0, symbol: .empty),
            Cell(x: 2, y: 0, symbol: .empty),
            Cell(x: 0, y: 1, symbol: .empty),
          ]),
        ) //
        .build();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playGame = createPlayGame(gameRepository);

    // then
    expect(() async {
      // when
      await playGame.execute(PlayGameCommand(x: 99, y: 99));
    }, throwsA(isA<CellNotAvailableException>()));
  });

  test("Can play on an empty cell that exist", () async {
    // given
    final game = aGame()
        .board(
          Board([
            Cell(x: 0, y: 0, symbol: .empty),
            Cell(x: 1, y: 0, symbol: .empty),
            Cell(x: 0, y: 1, symbol: .empty),
            Cell(x: 1, y: 1, symbol: .empty),
          ]),
        ) //
        .build();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playGame = createPlayGame(gameRepository);

    // when
    final currentGame = await playGame.execute(PlayGameCommand(x: 0, y: 0));

    // then
    expect(currentGame, isA<IaTurnGame>());
    final expectedBoard = Board([
      Cell(x: 0, y: 0, symbol: .x),
      Cell(x: 1, y: 0, symbol: .empty),
      Cell(x: 0, y: 1, symbol: .empty),
      Cell(x: 1, y: 1, symbol: .empty),
    ]);
    expect(currentGame.board, equals(expectedBoard));
  });
}
