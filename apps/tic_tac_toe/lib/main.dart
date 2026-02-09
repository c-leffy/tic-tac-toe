import 'package:analytics/analytics.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:login/login.dart';
import 'package:tic_tac_toe/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final firebaseReady = await _initFirebase();
  runApp(
    ProviderScope(
      overrides: [if (!firebaseReady) analyticsProvider.overrideWithValue(const NoAnalytics())],
      child: const TicTacToeApp(),
    ),
  );
}

Future<bool> _initFirebase() async {
  try {
    await dotenv.load(fileName: '.env');
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return true;
  } catch (_) {
    return false;
  }
}

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.coreL10n.appTitle,
      theme: appTheme,
      routerConfig: router,
      localizationsDelegates: const [
        CoreLocalizations.delegate,
        GameLocalizations.delegate,
        LoginLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: CoreLocalizations.supportedLocales,
    );
  }
}
