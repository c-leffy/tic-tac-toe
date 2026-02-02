import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tic_tac_toe/game/application/usecases/play_ia.dart';
import 'package:tic_tac_toe/game/infrastructure/persistence/inmemory/in_memory_game_repository.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/exception/not_ia_turn_exception.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';

import '../builder/game_builder.dart';

void main() {
  test("Can't play if there is no game", () async {
    // given
    final GameRepository gameRepository = InMemoryGameRepository();
    final playIa = PlayIa(gameRepository);

    // then
    expect(() async {
      await playIa.execute();
    }, throwsA(isA<NoGameStartedException>()));
  });

  test("Can't play if this is not the IA's turn", () async {
    // given
    final game = aGame().build();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playIa = PlayIa(gameRepository);

    // then
    expect(() async {
      await playIa.execute();
    }, throwsA(isA<NotIaTurnException>()));
  });

  test("Should place Symbol.o and transition to PlayerTurnGame", () async {
    // given
    final game = aGame().buildIaTurn();
    final GameRepository gameRepository = InMemoryGameRepository(game: game);
    final playIa = PlayIa(gameRepository);

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
    final playIa = PlayIa(gameRepository);

    // when
    await playIa.execute();

    // then
    final savedGame = await gameRepository.currentGame();
    expect(savedGame, isA<PlayerTurnGame>());
  });
}
