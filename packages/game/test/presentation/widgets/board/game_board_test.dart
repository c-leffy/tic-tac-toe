import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';

import '../../viewmodel/spy_game_notifier.dart';
import '../../viewmodel/stub_game_notifier.dart';

void main() {
  Widget createWidgetWithNotifier(StubGameNotifier notifier) => ProviderScope(
    overrides: [gameNotifierProvider.overrideWith(() => notifier)],
    child: MaterialApp(home: Scaffold(body: GameBoard())),
  );

  Widget createWidget({required BoardViewModel board, bool isPlayerTurn = true}) {
    final state = isPlayerTurn ? PlayerTurnScreenState(board) : IaTurnScreenState(board);
    return createWidgetWithNotifier(StubGameNotifier(AsyncData(state)));
  }

  BoardViewModel createBoard({List<(int x, int y, Symbol symbol)> plays = const []}) {
    var board = Board.generate3x3();
    for (final (x, y, symbol) in plays) {
      board = board.playAt(x, y, symbol);
    }
    return BoardViewModel.from(board);
  }

  final emptyBoard = createBoard();

  testWidgets('Should display 9 cells', (tester) async {
    // given
    await tester.pumpWidget(createWidget(board: emptyBoard));
    await tester.pumpAndSettle();

    // then
    expect(find.byType(CellWidget), findsNWidgets(9));
  });

  testWidgets('Should display an empty board when all cells are empty', (tester) async {
    // given
    await tester.pumpWidget(createWidget(board: emptyBoard));
    await tester.pumpAndSettle();

    // then
    expect(find.text('X'), findsNothing);
    expect(find.text('O'), findsNothing);
  });

  testWidgets('Should display X and O symbols at correct positions', (tester) async {
    // given
    final board = createBoard(
      plays: [
        (0, 2, Symbol.x),
        (2, 2, Symbol.o), //
        (1, 1, Symbol.x),
        (0, 0, Symbol.o),
      ],
    );

    await tester.pumpWidget(createWidget(board: board));
    await tester.pumpAndSettle();

    // then
    expect(find.text('X'), findsNWidgets(2));
    expect(find.text('O'), findsNWidgets(2));
  });

  testWidgets("When it is the player's turn, should put a symbol", (tester) async {
    // given
    final notifier = SpyGameNotifier(AsyncData(PlayerTurnScreenState(emptyBoard)));
    await tester.pumpWidget(createWidgetWithNotifier(notifier));
    await tester.pumpAndSettle();

    // when
    final cells = find.byType(CellWidget);
    await tester.tap(cells.at(4));

    // then
    expect(notifier.playCalls, contains((1, 1)));
  });

  testWidgets("When it is not the player's turn, should do nothing", (tester) async {
    // given
    final notifier = SpyGameNotifier(AsyncData(IaTurnScreenState(emptyBoard)));
    await tester.pumpWidget(createWidgetWithNotifier(notifier));
    await tester.pumpAndSettle();

    // when
    final cells = find.byType(CellWidget);
    await tester.tap(cells.at(4));

    // then
    expect(notifier.playCalls, isEmpty);
  });
}
