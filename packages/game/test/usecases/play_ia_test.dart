import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:game/game.dart';
import 'package:analytics/analytics.dart';

import '../builder/game_builder.dart';

PlayIa createPlayIa(GameRepository gameRepository) => PlayIa(gameRepository, const NoAnalytics());

void main() {
  test("Can't play if there is no game", () async {
    // given
    final GameRepository gameRepository = InMemoryGameRepository();
    final playIa = createPlayIa(gameRepository);

    // then
    expect(() async {
      await playIa.execute();
    }, throwsA(isA<NoGameStartedException>()));
  });

  test("Can't play if this is not the IA's turn", () async {
    // given
    final game = aGame().build();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playIa = createPlayIa(gameRepository);

    // then
    expect(() async {
      await playIa.execute();
    }, throwsA(isA<NotIaTurnException>()));
  });

  test("Should place Symbol.o and transition to PlayerTurnGame", () async {
    // given
    final game = aGame().buildIaTurn();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playIa = createPlayIa(gameRepository);

    // when
    final updatedGame = await playIa.execute();

    // then
    expect(updatedGame, isA<PlayerTurnGame>());
    final placedCells = updatedGame.board.rows.expand((row) => row).where((cell) => cell.symbol == Symbol.o);
    expect(placedCells.length, 1);
  });

  test("Should save the game to the repository", () async {
    // given
    final game = aGame().buildIaTurn();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playIa = createPlayIa(gameRepository);

    // when
    await playIa.execute();

    // then
    final savedGame = await gameRepository.currentGame();
    expect(savedGame, isA<PlayerTurnGame>());
  });
}
