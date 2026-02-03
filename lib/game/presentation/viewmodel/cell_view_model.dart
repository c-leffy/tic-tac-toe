import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/symbol_view_model.dart';

class CellViewModel extends Equatable {
  final int x;
  final int y;
  final SymbolViewModel symbol;

  const CellViewModel({required this.x, required this.y, required this.symbol});

  factory CellViewModel.from(Cell cell) => CellViewModel(
    x: cell.x,
    y: cell.y,
    symbol: SymbolViewModel.from(cell.symbol),
  );

  @override
  List<Object?> get props => [x, y, symbol];
}
