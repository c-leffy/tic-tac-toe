import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/game/application/usecases/start_game.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/infrastructure/configuration/game_configuration.dart';
import 'package:tic_tac_toe/game/presentation/view/home_page.dart';
import 'package:tic_tac_toe/game/presentation/widgets/game/difficulty_dialog.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

void main() {
  Widget createWidget({StartGame? startGameUseCase}) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/game', builder: (_, __) => const Scaffold(body: Text('Game Page'))),
      ],
    );

    return ProviderScope(
      overrides: [
        if (startGameUseCase != null) startGameUseCaseProvider.overrideWithValue(startGameUseCase),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
      ),
    );
  }

  testWidgets('When play button is pressed, should open the difficulty dialog', (tester) async {
    // given
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    // when
    await tester.scrollUntilVisible(find.text('Play'), 100);
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    // then
    expect(find.byType(DifficultyDialog), findsOneWidget);
  });

  testWidgets('When difficulty is selected, should navigate to game page', (tester) async {
    // given
    await tester.pumpWidget(createWidget(startGameUseCase: _FakeStartGame()));
    await tester.pumpAndSettle();

    // when
    await tester.scrollUntilVisible(find.text('Play'), 100);
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Easy'));
    await tester.pumpAndSettle();

    // then
    expect(find.text('Game Page'), findsOneWidget);
  });
}

class _FakeStartGame implements StartGame {
  @override
  Future<Game> execute(StartGameCommand command) async =>
      PlayerTurnGame(board: Board.generate3x3(), difficulty: command.difficulty);
}
