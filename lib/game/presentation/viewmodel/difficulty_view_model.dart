import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

enum DifficultyViewModel {
  easy(Color(0xFF22C55E), Difficulty.easy),
  medium(Color(0xFFFFE500), Difficulty.medium),
  hard(Color(0xFFEF4444), Difficulty.difficult);

  const DifficultyViewModel(this.color, this.difficulty);

  final Color color;
  final Difficulty difficulty;

  String label(AppLocalizations l10n) => switch (this) {
    easy => l10n.gameDifficultyEasy,
    medium => l10n.gameDifficultyMedium,
    hard => l10n.gameDifficultyHard,
  };

  Difficulty toDomain() => difficulty;

  static List<DifficultyViewModel> get all => values;
}
