import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/style/size.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/cell_view_model.dart';
import 'package:tic_tac_toe/game/presentation/widgets/cell/cell_widget.dart';

class BoardRow extends StatelessWidget {
  final List<CellViewModel> cells;
  final double cellSize;
  final void Function(int x, int y)? onCellTap;

  const BoardRow({super.key, required this.cells, required this.cellSize, this.onCellTap});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: Size.small,
    children: cells
        .map(
          (cell) => CellWidget(
            cell: cell,
            size: cellSize,
            onTap: onCellTap != null ? () => onCellTap!(cell.x, cell.y) : null,
          ),
        )
        .toList(),
  );
}
