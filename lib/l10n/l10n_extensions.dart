import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

/// Extension providing easy access to core localization strings.
extension CoreL10n on AppLocalizations {
  String get appTitle => coreAppTitle;
  String error(String message) => coreError(message);
  String get backToHome => coreBackToHome;
}

/// Convenience extension on BuildContext for quick l10n access.
extension CoreL10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
