// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'game_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class GameLocalizationsEn extends GameLocalizations {
  GameLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String welcome(String userName) {
    return 'Welcome $userName, let\'s play !';
  }

  @override
  String get play => 'Play';

  @override
  String get playAgain => 'Play again';

  @override
  String get chooseDifficulty => 'Choose difficulty';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get statusPlayerTurn => 'Your turn';

  @override
  String get statusIaThinking => 'AI is thinking...';

  @override
  String get statusVictory => 'Victory!';

  @override
  String get statusDefeat => 'Defeat!';

  @override
  String get statusDraw => 'Draw!';
}
