// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'core_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CoreLocalizationsEn extends CoreLocalizations {
  CoreLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get backToHome => 'Back to home';
}
