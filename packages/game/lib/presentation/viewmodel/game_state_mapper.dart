import 'package:game/domain/model/game.dart';
import 'package:game/domain/model/state/draw_game.dart';
import 'package:game/domain/model/state/ia_turn_game.dart';
import 'package:game/domain/model/state/ia_won_game.dart';
import 'package:game/domain/model/state/player_turn_game.dart';
import 'package:game/domain/model/state/player_won_game.dart';
import 'package:game/presentation/viewmodel/board_view_model.dart';
import 'package:game/presentation/viewmodel/game_screen_state.dart';

extension GameStateMapper on Game {
  GameScreenState toState() {
    final boardViewModel = BoardViewModel.from(board);
    return switch (this) {
      PlayerTurnGame() => PlayerTurnScreenState(boardViewModel),
      IaTurnGame() => IaTurnScreenState(boardViewModel),
      PlayerWonGame() => VictoryScreenState(boardViewModel),
      IaWonGame() => DefeatScreenState(boardViewModel),
      DrawGame() => DrawScreenState(boardViewModel),
      _ => throw StateError('Unknown game state: $this'),
    };
  }
}
