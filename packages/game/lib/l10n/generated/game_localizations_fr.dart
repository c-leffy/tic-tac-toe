// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'game_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class GameLocalizationsFr extends GameLocalizations {
  GameLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get play => 'Jouer';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get chooseDifficulty => 'Choisir la difficulté';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Moyen';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get statusPlayerTurn => 'À vous de jouer';

  @override
  String get statusIaThinking => 'L\'IA réfléchit...';

  @override
  String get statusVictory => 'Victoire !';

  @override
  String get statusDefeat => 'Défaite !';

  @override
  String get statusDraw => 'Match nul !';
}
