import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tic_tac_toe/game/application/usecases/start_game.dart';
import 'package:tic_tac_toe/game/infrastructure/persistence/inmemory/in_memory_game_repository.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';

import '../builder/game_builder.dart';

void main() {
  test("With no game in progress, should start a new game", () async {
    // given
    final GameRepository gameRepository = InMemoryGameRepository();
    final command = StartGameCommand(difficulty: .medium);
    final startGame = StartGame(gameRepository);

    // when
    final game = await startGame.execute(command);

    // then
    final expectedGame = aGame()
        .board(Board.generate3x3()) //
        .difficulty(.medium)
        .build();
    expect(game, equals(expectedGame));

    final savedGame = await gameRepository.currentGame();
    expect(savedGame, equals(game));
  });

  test("With already a game in progress, should start a new game", () async {
    // given
    final gameInProgress = aGame()
        .difficulty(.easy) //
        .build();
    final GameRepository gameRepository = InMemoryGameRepository(game: gameInProgress);
    final command = StartGameCommand(difficulty: .difficult);
    final startGame = StartGame(gameRepository);

    // when
    final game = await startGame.execute(command);

    // then
    final expectedGame = aGame()
        .board(Board.generate3x3()) //
        .difficulty(.difficult)
        .build();
    expect(game, equals(expectedGame));

    final savedGame = await gameRepository.currentGame();
    expect(savedGame, equals(game));
  });
}
