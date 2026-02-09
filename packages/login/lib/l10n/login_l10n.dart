import 'package:flutter/widgets.dart';
import 'package:login/l10n/generated/login_localizations.dart';

export 'generated/login_localizations.dart';

extension LoginL10nContext on BuildContext {
  LoginLocalizations get loginL10n => LoginLocalizations.of(this)!;
}
