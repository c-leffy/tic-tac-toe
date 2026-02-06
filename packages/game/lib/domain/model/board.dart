import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'package:game/domain/exception/cell_not_available_exception.dart';
import 'package:game/domain/model/cell.dart';
import 'package:game/domain/model/symbol.dart';

class Board extends Equatable {
  final List<Cell> _cells;

  Board(List<Cell> cells) : _cells = [...cells];

  factory Board.generate3x3() {
    return Board(List.generate(9, (index) => Cell(x: index % 3, y: index ~/ 3)));
  }

  Iterable<List<Cell>> get rows => _cells.groupBy((cell) => cell.y).values;

  Iterable<List<Cell>> get columns => _cells.groupBy((cell) => cell.x).values;

  Iterable<Iterable<Cell>> get diagonals => [_mainDiagonal, _antiDiagonal];

  Iterable<Cell> get emptyCells => _cells.where((cell) => cell.symbol == Symbol.empty);

  bool isFull() => _cells.every((cell) => cell.symbol != Symbol.empty);

  Board playAt(int x, int y, Symbol symbol) {
    final cellIndex = _cells.indexWhere((cell) => cell.x == x && cell.y == y && cell.symbol == Symbol.empty);

    if (cellIndex == -1) {
      throw CellNotAvailableException(x: x, y: y);
    }

    final updatedCells = [..._cells];
    updatedCells[cellIndex] = Cell(x: x, y: y, symbol: symbol);

    return Board(updatedCells);
  }

  Iterable<Cell> get _mainDiagonal => _cells.where((cell) => cell.x == cell.y);

  Iterable<Cell> get _antiDiagonal => _cells.where((cell) => cell.x + cell.y == 2);

  @override
  List<Object?> get props => [_cells];
}
