import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:game/game.dart';
import 'package:analytics/analytics.dart';

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
