import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget createWidget({StartGame? startGameUseCase}) {
    final router = GoRouter(
      initialLocation: GameRoutes.home.path,
      routes: [
        GoRoute(path: GameRoutes.home.path, builder: (_, _) => const HomePage()),
        GoRoute(
          path: GameRoutes.game.path,
          builder: (_, _) => const Scaffold(body: Text('Game Page')),
        ),
      ],
    );

    return ProviderScope(
      overrides: [if (startGameUseCase != null) startGameUseCaseProvider.overrideWithValue(startGameUseCase)],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          CoreLocalizations.delegate,
          GameLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: CoreLocalizations.supportedLocales,
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
