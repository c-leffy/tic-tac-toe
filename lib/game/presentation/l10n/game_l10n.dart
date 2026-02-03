import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

/// Extension providing easy access to game localization strings.
extension GameL10n on AppLocalizations {
  String get play => gamePlay;
  String get playAgain => gamePlayAgain;
  String get chooseDifficulty => gameChooseDifficulty;
  String get difficultyEasy => gameDifficultyEasy;
  String get difficultyMedium => gameDifficultyMedium;
  String get difficultyHard => gameDifficultyHard;
  String get statusPlayerTurn => gameStatusPlayerTurn;
  String get statusIaThinking => gameStatusIaThinking;
  String get statusVictory => gameStatusVictory;
  String get statusDefeat => gameStatusDefeat;
  String get statusDraw => gameStatusDraw;
}
