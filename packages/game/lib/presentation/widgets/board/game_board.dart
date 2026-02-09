import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

class GameBoard extends StatelessWidget {
  static const double _maxBoardSize = 360.0;

  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final boardSize = constraints.maxWidth.clamp(0.0, _maxBoardSize);
      final cellSize = (boardSize - Size.small * 2 - Size.medium * 2) / 3;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Size.small),
        child: NeoCard(
          width: boardSize,
          child: _CellsWidget(cellSize: cellSize),
        ),
      );
    },
  );
}

class _CellsWidget extends ConsumerWidget {
  final double cellSize;

  const _CellsWidget({required this.cellSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(gameNotifierProvider.select((it) => it.value?.board ?? BoardViewModel.empty()));
    final isPlayerTurn = ref.watch(gameNotifierProvider.select((it) => it.value?.isPlayerTurn ?? false));

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Size.small,
      crossAxisSpacing: Size.small,
      children: board.cells
          .map(
            (cell) => CellWidget(
              cell: cell,
              size: cellSize,
              onTap: isPlayerTurn ? () => ref.read(gameNotifierProvider.notifier).play(cell.x, cell.y) : null,
            ),
          )
          .toList(),
    );
  }
}
