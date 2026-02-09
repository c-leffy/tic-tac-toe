import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';

import '../viewmodel/stub_game_notifier.dart';

void main() {
  Widget createWidget(AsyncValue<GameScreenState> state) => ProviderScope(
    overrides: [gameNotifierProvider.overrideWith(() => StubGameNotifier(state))],
    child: MaterialApp(
      localizationsDelegates: const [CoreLocalizations.delegate, GameLocalizations.delegate],
      supportedLocales: CoreLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: GamePage(),
    ),
  );

  group('When game is in progress,', () {
    // given
    final state = AsyncData(PlayerTurnScreenState(BoardViewModel.empty()));

    testWidgets('Should display home button, status bar and board', (tester) async {
      // when
      await tester.pumpWidget(createWidget(state));
      await tester.pumpAndSettle();

      // then
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byType(GameStatusBar), findsOneWidget);
      expect(find.byType(GameBoard), findsOneWidget);
    });

    testWidgets('Should not display the play again button', (tester) async {
      // when
      await tester.pumpWidget(createWidget(state));
      await tester.pumpAndSettle();

      // then
      final visibility = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibility.visible, isFalse);
    });
  });

  testWidgets('When game is over, should display the play again button', (tester) async {
    // given
    final state = AsyncData(VictoryScreenState(BoardViewModel.empty()));

    // when
    await tester.pumpWidget(createWidget(state));
    await tester.pumpAndSettle();

    // then
    expect(find.text('Play again'), findsOneWidget);
  });
}
