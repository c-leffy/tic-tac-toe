import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:game/domain/model/board.dart';
import 'package:game/presentation/viewmodel/cell_view_model.dart';

class BoardViewModel extends Equatable {
  final List<CellViewModel> cells;

  const BoardViewModel._(this.cells);

  /// Maps domain coordinates to display order.
  ///
  /// Domain uses Cartesian coordinates (y=0 at bottom):
  /// ```
  ///   y
  ///   2 | . . .
  ///   1 | . . .
  ///   0 | . . .
  ///     +-------
  ///       0 1 2  x
  /// ```
  ///
  /// Flutter renders top-to-bottom, so we sort by y descending
  /// to display y=2 first (at the top of the screen).
  factory BoardViewModel.from(Board board) => BoardViewModel._(
    board
        .rows //
        .sortedByDescending((row) => row.first.y)
        .expand((row) => row.map(CellViewModel.from))
        .toList(),
  );

  factory BoardViewModel.empty() => BoardViewModel._([]);

  @override
  List<Object?> get props => [cells];
}
