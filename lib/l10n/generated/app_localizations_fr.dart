// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get coreAppTitle => 'Tic Tac Toe';

  @override
  String coreError(String message) {
    return 'Erreur : $message';
  }

  @override
  String get coreBackToHome => 'Retour à l\'accueil';

  @override
  String get gamePlay => 'Jouer';

  @override
  String get gamePlayAgain => 'Rejouer';

  @override
  String get gameChooseDifficulty => 'Choisir la difficulté';

  @override
  String get gameDifficultyEasy => 'Facile';

  @override
  String get gameDifficultyMedium => 'Moyen';

  @override
  String get gameDifficultyHard => 'Difficile';

  @override
  String get gameStatusPlayerTurn => 'À vous de jouer';

  @override
  String get gameStatusIaThinking => 'L\'IA réfléchit...';

  @override
  String get gameStatusVictory => 'Victoire !';

  @override
  String get gameStatusDefeat => 'Défaite !';

  @override
  String get gameStatusDraw => 'Match nul !';
}
