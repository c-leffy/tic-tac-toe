import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/player.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

class Game extends Equatable {
  final Difficulty difficulty;
  final Board board;
  final Player player;
  final Player ia;

  const Game({required this.board, required this.player, required this.ia, this.difficulty = .easy});

  bool hasWinner() {
    return board.hasCompleteRow() || board.hasCompleteColumn() || board.hasCompleteDiagonal();
  }

  Game playAt({required int x, required int y, required Symbol symbol}) {
    final updatedBoard = board.playAt(x, y, symbol);
    return copyWith(board: updatedBoard);
  }

  @override
  List<Object?> get props => [difficulty, board, player, ia];

  Game copyWith({Difficulty? difficulty, Board? board, Player? player, Player? ia}) => Game(
    difficulty: difficulty ?? this.difficulty,
    board: board ?? this.board,
    player: player ?? this.player,
    ia: ia ?? this.ia,
  );
}
