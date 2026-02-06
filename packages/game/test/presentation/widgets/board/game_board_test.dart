import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';

void main() {
  Widget createWidget({
    required BoardViewModel board,
    bool isPlayerTurn = true,
    void Function(int x, int y)? onCellTap,
  }) => MaterialApp(
    home: Scaffold(
      body: Center(
        child: GameBoard(board: board, isPlayerTurn: isPlayerTurn, onCellTap: onCellTap),
      ),
    ),
  );

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

    // then
    expect(find.byType(CellWidget), findsNWidgets(9));
  });

  testWidgets('Should display an empty board when all cells are empty', (tester) async {
    // given
    await tester.pumpWidget(createWidget(board: emptyBoard));

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

    // then
    expect(find.text('X'), findsNWidgets(2));
    expect(find.text('O'), findsNWidgets(2));
  });

  testWidgets("When it is the player's turn, should trigger callback with correct coordinates on tap", (tester) async {
    // given
    var tappedX = 0;
    var tappedY = 0;

    await tester.pumpWidget(
      createWidget(
        board: emptyBoard,
        isPlayerTurn: true,
        onCellTap: (x, y) {
          tappedX = x;
          tappedY = y;
        },
      ),
    );

    // when
    final cells = find.byType(CellWidget);
    await tester.tap(cells.at(4)); // Centre du plateau (x=1, y=1)

    // then
    expect(tappedX, equals(1));
    expect(tappedY, equals(1));
  });

  testWidgets("When it is not the player's turn, should not trigger callback on tap", (tester) async {
    // given
    var callbackTriggered = false;

    await tester.pumpWidget(
      createWidget(
        board: emptyBoard,
        isPlayerTurn: false,
        onCellTap: (x, y) {
          callbackTriggered = true;
        },
      ),
    );

    // when
    final cells = find.byType(CellWidget);
    await tester.tap(cells.at(4));

    // then
    expect(callbackTriggered, isFalse);
  });
}
