import 'package:equatable/equatable.dart';
import 'package:game/domain/model/board.dart';
import 'package:game/domain/model/difficulty.dart';

abstract class Game extends Equatable {
  final Difficulty difficulty;
  final Board board;

  const Game({required this.board, this.difficulty = Difficulty.easy});

  Game playAt({required int x, required int y});

  @override
  List<Object?> get props => [difficulty, board];
}
