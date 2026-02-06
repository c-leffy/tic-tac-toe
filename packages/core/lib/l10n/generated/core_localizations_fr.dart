// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class CoreLocalizationsFr extends CoreLocalizations {
  CoreLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String error(String message) {
    return 'Erreur : $message';
  }

  @override
  String get backToHome => 'Retour à l\'accueil';
}
