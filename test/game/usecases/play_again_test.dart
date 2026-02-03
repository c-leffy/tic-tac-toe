import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/application/usecases/play_again.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/infrastructure/persistence/inmemory/in_memory_game_repository.dart';

import '../../analytics/fake/no_analytics.dart';
import '../builder/game_builder.dart';

PlayAgainGame createPlayAgain(GameRepository gameRepository) => PlayAgainGame(gameRepository, const NoAnalytics());

void main() {
  test("With no game in progress, should throw an error", () async {
    // given
    final GameRepository gameRepository = InMemoryGameRepository();
    final playAgain = createPlayAgain(gameRepository);

    // when / then
    expect(() => playAgain.execute(), throwsA(isA<NoGameStartedException>()));
  });

  for (final difficulty in Difficulty.values) {
    test(
      "With a game with ${difficulty.name} as difficulty, should start a new game with ${difficulty.name} as difficulty",
      () async {
        // given
        final gameInProgress = aGame().difficulty(difficulty).build();
        final GameRepository gameRepository = InMemoryGameRepository(game: gameInProgress);
        final playAgain = createPlayAgain(gameRepository);

        // when
        final game = await playAgain.execute();

        // then
        final expectedGame = aGame().board(Board.generate3x3()).difficulty(difficulty).build();
        expect(game, equals(expectedGame));

        final savedGame = await gameRepository.currentGame();
        expect(savedGame, equals(game));
      },
    );
  }
}
