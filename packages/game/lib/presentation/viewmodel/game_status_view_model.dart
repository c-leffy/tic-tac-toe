import 'package:flutter/material.dart';
import 'package:game/l10n/game_l10n.dart';
import 'package:game/presentation/viewmodel/game_screen_state.dart';

enum GameStatusViewModel {
  playerTurn(Color(0xFFFE7096)),
  iaThinking(Color(0xFF2563EB)),
  victory(Color(0xFF22C55E)),
  defeat(Color(0xFFEF4444)),
  draw(Color(0xFF6B7280));

  const GameStatusViewModel(this.color);

  final Color color;

  String message(GameLocalizations l10n) => switch (this) {
    playerTurn => l10n.statusPlayerTurn,
    iaThinking => l10n.statusIaThinking,
    victory => l10n.statusVictory,
    defeat => l10n.statusDefeat,
    draw => l10n.statusDraw,
  };

  static GameStatusViewModel from(GameScreenState state) => switch (state) {
    PlayerTurnScreenState() => playerTurn,
    IaTurnScreenState() => iaThinking,
    VictoryScreenState() => victory,
    DefeatScreenState() => defeat,
    DrawScreenState() => draw,
  };
}
