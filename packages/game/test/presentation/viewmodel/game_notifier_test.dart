import 'package:analytics/analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logs/logs.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:game/game.dart';

import '../../builder/game_builder.dart';

void main() {
  ProviderContainer createContainer({Game? game, bool listen = true}) {
    final repository = InMemoryGameRepository(game: game);
    final container = ProviderContainer(
      overrides: [
        gameRepositoryProvider.overrideWithValue(repository),
        iaDelayProvider.overrideWithValue(Duration.zero),
        analyticsProvider.overrideWithValue(const NoAnalytics()),
        logsProvider.overrideWithValue(const NoLogs()),
      ],
    );
    if (listen) container.listen(gameNotifierProvider, (_, _) {});
    return container;
  }

  test("With no game in progress, should throw an error", () async {
    // given
    final container = createContainer(listen: false);

    // when
    final future = container.read(gameNotifierProvider.future);

    // then
    expect(future, throwsA(anything));
  });

  test("With a game in progress, should return the current game state", () async {
    // given
    final container = createContainer(game: aGame().build());

    // when
    final state = await container.read(gameNotifierProvider.future);

    // then
    expect(state, isA<PlayerTurnScreenState>());
  });

  test("When playing again, should start a new game with the same difficulty", () async {
    // given
    final container = createContainer(game: aGame().difficulty(Difficulty.difficult).build());
    await container.read(gameNotifierProvider.future);

    // when
    await container.read(gameNotifierProvider.notifier).playAgain();

    // then
    final state = container.read(gameNotifierProvider).value;
    expect(state, isA<PlayerTurnScreenState>());
  });

  test("When player plays a valid move and game continues, should trigger IA and update to player's turn", () async {
    // given
    final container = createContainer(game: aGame().build());
    await container.read(gameNotifierProvider.future);

    // when
    await container.read(gameNotifierProvider.notifier).play(0, 0);

    // then
    final state = container.read(gameNotifierProvider).value;
    expect(state, isA<PlayerTurnScreenState>());
  });

  test("When player plays a winning move, should update state to victory", () async {
    // given
    // ┌───┬───┬───┐
    // │ X │ X │ _ │
    // ├───┼───┼───┤
    // │ O │ O │ _ │
    // ├───┼───┼───┤
    // │ _ │ _ │ _ │
    // └───┴───┴───┘
    final game = aGame()
        .board(
          Board([
            Cell(x: 0, y: 0, symbol: .empty),
            Cell(x: 1, y: 0, symbol: .empty),
            Cell(x: 2, y: 0, symbol: .empty),
            Cell(x: 0, y: 1, symbol: .o),
            Cell(x: 1, y: 1, symbol: .o),
            Cell(x: 2, y: 1, symbol: .empty),
            Cell(x: 0, y: 2, symbol: .x),
            Cell(x: 1, y: 2, symbol: .x),
            Cell(x: 2, y: 2, symbol: .empty),
          ]),
        )
        .build();
    final container = createContainer(game: game);
    await container.read(gameNotifierProvider.future);

    // when
    await container.read(gameNotifierProvider.notifier).play(2, 2);

    // then
    final state = container.read(gameNotifierProvider).value;
    expect(state, isA<VictoryScreenState>());
  });

  test("When player plays a move leading to draw, should update state to draw", () async {
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
    final container = createContainer(game: game);
    await container.read(gameNotifierProvider.future);

    // when
    await container.read(gameNotifierProvider.notifier).play(2, 2);

    // then
    final state = container.read(gameNotifierProvider).value;
    expect(state, isA<DrawScreenState>());
  });

  test("When IA plays a move leading to draw, should update state to draw", () async {
    // given
    // ┌───┬───┬───┐
    // │ X │ O │ X │
    // ├───┼───┼───┤
    // │ X │ O │ _ │
    // ├───┼───┼───┤
    // │ O │ X │ _ │
    // └───┴───┴───┘
    final game = aGame()
        .board(
          Board([
            Cell(x: 0, y: 0, symbol: .o),
            Cell(x: 1, y: 0, symbol: .x),
            Cell(x: 2, y: 0, symbol: .empty),
            Cell(x: 0, y: 1, symbol: .x),
            Cell(x: 1, y: 1, symbol: .o),
            Cell(x: 2, y: 1, symbol: .empty),
            Cell(x: 0, y: 2, symbol: .x),
            Cell(x: 1, y: 2, symbol: .o),
            Cell(x: 2, y: 2, symbol: .x),
          ]),
        )
        .build();
    final container = createContainer(game: game);
    await container.read(gameNotifierProvider.future);

    // when
    await container.read(gameNotifierProvider.notifier).play(2, 1);

    // then
    final state = container.read(gameNotifierProvider).value;
    expect(state, isA<DrawScreenState>());
  });

  test("When play throws an error, should keep previous state", () async {
    // given
    final container = createContainer(game: aGame().buildIaTurn());
    await container.read(gameNotifierProvider.future);
    final stateBefore = container.read(gameNotifierProvider).value;

    // when
    await container.read(gameNotifierProvider.notifier).play(0, 0);

    // then
    final stateAfter = container.read(gameNotifierProvider).value;
    expect(stateAfter, equals(stateBefore));
  });
}
