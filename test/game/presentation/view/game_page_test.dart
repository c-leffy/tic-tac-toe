import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/presentation/view/game_page.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/board_view_model.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_notifier.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_screen_state.dart';
import 'package:tic_tac_toe/game/presentation/widgets/board/game_board.dart';
import 'package:tic_tac_toe/game/presentation/widgets/game/game_status_bar.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

void main() {
  final emptyBoard = BoardViewModel.from(Board.generate3x3());

  Widget createWidget(AsyncValue<GameScreenState> state) => ProviderScope(
    overrides: [gameNotifierProvider.overrideWith(() => _FakeGameNotifier(state))],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      home: GamePage(),
    ),
  );

  group('When game is in progress,', () {
    // given
    final state = AsyncData(PlayerTurnScreenState(emptyBoard));

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
    final state = AsyncData(VictoryScreenState(emptyBoard));

    // when
    await tester.pumpWidget(createWidget(state));
    await tester.pumpAndSettle();

    // then
    expect(find.text('Play again'), findsOneWidget);
  });
}

class _FakeGameNotifier extends GameNotifier {
  final AsyncValue<GameScreenState> _state;

  _FakeGameNotifier(this._state);

  @override
  Future<GameScreenState> build() async => _state.value!;
}
