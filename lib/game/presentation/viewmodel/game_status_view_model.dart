import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_screen_state.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

enum GameStatusViewModel {
  playerTurn(Color(0xFF3B82F6)),
  iaThinking(Color(0xFFF97316)),
  victory(Color(0xFF22C55E)),
  defeat(Color(0xFFEF4444)),
  draw(Color(0xFF6B7280));

  const GameStatusViewModel(this.color);

  final Color color;

  String message(AppLocalizations l10n) => switch (this) {
    playerTurn => l10n.gameStatusPlayerTurn,
    iaThinking => l10n.gameStatusIaThinking,
    victory => l10n.gameStatusVictory,
    defeat => l10n.gameStatusDefeat,
    draw => l10n.gameStatusDraw,
  };

  static GameStatusViewModel from(GameScreenState state) => switch (state) {
    PlayerTurnScreenState() => playerTurn,
    IaTurnScreenState() => iaThinking,
    VictoryScreenState() => victory,
    DefeatScreenState() => defeat,
    DrawScreenState() => draw,
  };
}
