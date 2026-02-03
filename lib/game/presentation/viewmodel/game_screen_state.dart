import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/board_view_model.dart';

sealed class GameScreenState extends Equatable {
  final BoardViewModel board;

  const GameScreenState(this.board);

  bool get isPlayerTurn => false;

  bool get isGameOver => false;

  @override
  List<Object?> get props => [board];
}

class PlayerTurnScreenState extends GameScreenState {
  const PlayerTurnScreenState(super.board);

  @override
  bool get isPlayerTurn => true;
}

class IaTurnScreenState extends GameScreenState {
  const IaTurnScreenState(super.board);
}

class VictoryScreenState extends GameScreenState {
  const VictoryScreenState(super.board);

  @override
  bool get isGameOver => true;
}

class DefeatScreenState extends GameScreenState {
  const DefeatScreenState(super.board);

  @override
  bool get isGameOver => true;
}

class DrawScreenState extends GameScreenState {
  const DrawScreenState(super.board);

  @override
  bool get isGameOver => true;
}
