import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';

import '../../viewmodel/stub_game_notifier.dart';

void main() {
  Widget createWidget(GameScreenState state) => ProviderScope(
    overrides: [gameNotifierProvider.overrideWith(() => StubGameNotifier(AsyncData(state)))],
    child: MaterialApp(
      localizationsDelegates: const [GameLocalizations.delegate],
      supportedLocales: CoreLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: GameStatusBar()),
    ),
  );

  final board = BoardViewModel.from(Board.generate3x3());

  final scenarios = [
    (PlayerTurnScreenState(board), 'Your turn'),
    (IaTurnScreenState(board), 'AI is thinking...'),
    (VictoryScreenState(board), 'Victory!'),
    (DefeatScreenState(board), 'Defeat!'),
    (DrawScreenState(board), 'Draw!'),
  ];

  for (final (state, expectedMessage) in scenarios) {
    final status = GameStatusViewModel.from(state);
    group("With ${status.name} status,", () {
      testWidgets("should display '$expectedMessage'", (tester) async {
        // given
        await tester.pumpWidget(createWidget(state));
        await tester.pumpAndSettle();

        // then
        expect(find.text(expectedMessage), findsOneWidget);
      });

      testWidgets("should have correct background color", (tester) async {
        // given
        await tester.pumpWidget(createWidget(state));
        await tester.pumpAndSettle();

        // when
        final container = tester.widget<Container>(find.byType(Container).first);
        final decoration = container.decoration as BoxDecoration;

        // then
        expect(decoration.color, equals(status.color));
      });
    });
  }
}
