import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/presentation/widgets/neo_card.dart';
import 'package:tic_tac_toe/core/style/size.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/board_view_model.dart';
import 'package:tic_tac_toe/game/presentation/widgets/cell/cell_widget.dart';

class GameBoard extends StatelessWidget {
  final BoardViewModel board;
  final bool isPlayerTurn;
  final void Function(int x, int y)? onCellTap;
  static const double _maxBoardSize = 360.0;

  const GameBoard({super.key, required this.board, required this.isPlayerTurn, this.onCellTap});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final boardSize = constraints.maxWidth.clamp(0.0, _maxBoardSize);
      final cellSize = (boardSize - Size.small * 2 - Size.medium * 2) / 3;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Size.small),
        child: NeoCard(
          child: GridView.count(
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
                    onTap: isPlayerTurn ? () => onCellTap?.call(cell.x, cell.y) : null,
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}
