import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:game/presentation/viewmodel/cell_view_model.dart';
import 'package:game/presentation/widgets/cell/symbol_icon.dart';

class CellWidget extends StatelessWidget {
  final CellViewModel cell;
  final double size;
  final VoidCallback? onTap;

  const CellWidget({super.key, required this.cell, required this.size, this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border, width: Size.tiny),
        borderRadius: BorderRadius.circular(Size.tiny),
      ),
      child: SymbolIcon(symbol: cell.symbol),
    ),
  );
}
