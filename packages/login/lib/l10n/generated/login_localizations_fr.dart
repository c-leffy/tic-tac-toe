// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'login_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LoginLocalizationsFr extends LoginLocalizations {
  LoginLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get register => 'S\'enregistrer';

  @override
  String get nameHint => 'Entrez votre nom';

  @override
  String get invalidName => 'Veuillez entrer un nom valide';
}
