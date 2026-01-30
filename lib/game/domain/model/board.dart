import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/core/collections/group_by.dart';
import 'package:tic_tac_toe/game/domain/exception/cell_not_available_exception.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

class Board extends Equatable {
  final List<Cell> _cells;

  Board(List<Cell> cells) : _cells = [...cells];

  factory Board.generate3x3() {
    return Board(List.generate(9, (index) => Cell(x: index % 3, y: index ~/ 3)));
  }

  bool hasCompleteRow() => _rows.any(_isComplete);

  bool hasCompleteColumn() => _columns.any(_isComplete);

  bool hasCompleteDiagonal() => _diagonals.any(_isComplete);

  Board playAt(int x, int y, Symbol symbol) {
    final cellIndex = _cells.indexWhere((cell) => cell.x == x && cell.y == y && cell.symbol == Symbol.empty);

    if (cellIndex == -1) {
      throw CellNotAvailableException(x: x, y: y);
    }

    final updatedCells = [..._cells];
    updatedCells[cellIndex] = Cell(x: x, y: y, symbol: symbol);

    return Board(updatedCells);
  }

  Iterable<List<Cell>> get _rows => _cells.groupBy((cell) => cell.y).values;

  Iterable<List<Cell>> get _columns => _cells.groupBy((cell) => cell.x).values;

  Iterable<Cell> get _mainDiagonal => _cells.where((cell) => cell.x == cell.y);

  Iterable<Cell> get _antiDiagonal => _cells.where((cell) => cell.x + cell.y == 2);

  Iterable<Iterable<Cell>> get _diagonals => [_mainDiagonal, _antiDiagonal];

  bool _isComplete(Iterable<Cell> cells) =>
      cells.every((cell) => cell.symbol != Symbol.empty) && //
      cells.every((cell) => cell.symbol == cells.first.symbol);

  @override
  List<Object?> get props => [_cells];
}
