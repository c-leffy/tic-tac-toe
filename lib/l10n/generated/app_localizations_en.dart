// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get coreAppTitle => 'Tic Tac Toe';

  @override
  String coreError(String message) {
    return 'Error: $message';
  }

  @override
  String get coreBackToHome => 'Back to home';

  @override
  String get gamePlay => 'Play';

  @override
  String get gamePlayAgain => 'Play again';

  @override
  String get gameChooseDifficulty => 'Choose difficulty';

  @override
  String get gameDifficultyEasy => 'Easy';

  @override
  String get gameDifficultyMedium => 'Medium';

  @override
  String get gameDifficultyHard => 'Hard';

  @override
  String get gameStatusPlayerTurn => 'Your turn';

  @override
  String get gameStatusIaThinking => 'AI is thinking...';

  @override
  String get gameStatusVictory => 'Victory!';

  @override
  String get gameStatusDefeat => 'Defeat!';

  @override
  String get gameStatusDraw => 'Draw!';
}
