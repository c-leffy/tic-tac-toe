import 'package:flutter/material.dart';
import 'package:game/domain/model/difficulty.dart';
import 'package:game/l10n/game_l10n.dart';

enum DifficultyViewModel {
  easy(Color(0xFF22C55E), Difficulty.easy),
  medium(Color(0xFFFFE500), Difficulty.medium),
  hard(Color(0xFFEF4444), Difficulty.difficult);

  const DifficultyViewModel(this.color, this.difficulty);

  final Color color;
  final Difficulty difficulty;

  String label(GameLocalizations l10n) => switch (this) {
    easy => l10n.difficultyEasy,
    medium => l10n.difficultyMedium,
    hard => l10n.difficultyHard,
  };

  Difficulty toDomain() => difficulty;

  static List<DifficultyViewModel> get all => values;
}
