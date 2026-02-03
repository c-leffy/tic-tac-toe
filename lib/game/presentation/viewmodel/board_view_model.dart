import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/core/collections/sorted_by.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/cell_view_model.dart';

class BoardViewModel extends Equatable {
  final List<List<CellViewModel>> rows;

  const BoardViewModel._(this.rows);

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
  /// Flutter renders top-to-bottom, so rows[0] appears at the top.
  /// We sort by y descending to display y=2 first (at the top of the screen).
  factory BoardViewModel.from(Board board) => BoardViewModel._(
    board.rows
        .sortedByDescending((row) => row.first.y)
        .map((row) => row.map(CellViewModel.from).toList())
        .toList(),
  );

  @override
  List<Object?> get props => [rows];
}
