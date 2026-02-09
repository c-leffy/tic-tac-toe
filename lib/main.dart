import 'package:analytics/analytics.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:login/login.dart';
import 'package:tic_tac_toe/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: TicTacToeApp()));
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.coreL10n.appTitle,
      theme: appTheme,
      routerConfig: router,
      localizationsDelegates: const [
        CoreLocalizations.delegate,
        GameLocalizations.delegate,
        LoginLocalizations.delegate,
      ],
      supportedLocales: CoreLocalizations.supportedLocales,
    );
  }
}
