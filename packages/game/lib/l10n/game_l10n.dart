import 'package:flutter/widgets.dart';
import 'package:game/l10n/generated/game_localizations.dart';

export 'generated/game_localizations.dart';

extension GameL10nContext on BuildContext {
  GameLocalizations get gameL10n => GameLocalizations.of(this)!;
}
