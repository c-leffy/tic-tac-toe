import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:game/game.dart';

void main() {
  Widget createWidget(GameStatusViewModel status) => MaterialApp(
    localizationsDelegates: const [
      CoreLocalizations.delegate,
      GameLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: CoreLocalizations.supportedLocales,
    locale: const Locale('en'),
    home: Scaffold(body: GameStatusBar(status: status)),
  );

  final scenarios = [
    (GameStatusViewModel.playerTurn, 'Your turn'),
    (GameStatusViewModel.iaThinking, 'AI is thinking...'),
    (GameStatusViewModel.victory, 'Victory!'),
    (GameStatusViewModel.defeat, 'Defeat!'),
    (GameStatusViewModel.draw, 'Draw!'),
  ];

  for (final (status, expectedMessage) in scenarios) {
    group("With ${status.name} status,", () {
      testWidgets("should display '$expectedMessage'", (tester) async {
        // given
        await tester.pumpWidget(createWidget(status));
        await tester.pumpAndSettle();

        // then
        expect(find.text(expectedMessage), findsOneWidget);
      });

      testWidgets("should have correct background color", (tester) async {
        // given
        await tester.pumpWidget(createWidget(status));
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
