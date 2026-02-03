import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_status_view_model.dart';
import 'package:tic_tac_toe/game/presentation/widgets/game/game_status_bar.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

void main() {
  Widget createWidget(GameStatusViewModel status) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
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
