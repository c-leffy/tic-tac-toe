import 'package:flutter/widgets.dart';
import 'package:core/l10n/generated/core_localizations.dart';

export 'generated/core_localizations.dart';

extension CoreL10nContext on BuildContext {
  CoreLocalizations get coreL10n => CoreLocalizations.of(this)!;
}
