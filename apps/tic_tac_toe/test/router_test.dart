import 'package:analytics/analytics.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/game.dart';
import 'package:go_router/go_router.dart';
import 'package:login/login.dart';
import 'package:tic_tac_toe/router.dart';

void main() {
  Widget createApp({required PlayerRepository repository}) => ProviderScope(
    overrides: [
      playerRepositoryProvider.overrideWith((ref) async => repository),
      analyticsProvider.overrideWithValue(const NoAnalytics()),
    ],
    child: Consumer(
      builder: (context, ref, _) => MaterialApp.router(
        routerConfig: ref.watch(routerProvider),
        localizationsDelegates: const [
          CoreLocalizations.delegate,
          GameLocalizations.delegate,
          LoginLocalizations.delegate,
        ],
        supportedLocales: CoreLocalizations.supportedLocales,
        locale: const Locale('en'),
      ),
    ),
  );

  group("When user is not registered", () {
    final repository = InMemoryPlayerRepository();

    testWidgets("should redirect '/' to '/register'", (tester) async {
      // given — initial location defaults to "/"
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // then
      expect(find.byType(RegisterPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
    });

    testWidgets("should redirect '/game' to '/register'", (tester) async {
      // given
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // when
      final context = tester.element(find.byType(RegisterPage));
      GoRouter.of(context).go(GameRoutes.game.path);
      await tester.pumpAndSettle();

      // then
      expect(find.byType(RegisterPage), findsOneWidget);
      expect(find.byType(GamePage), findsNothing);
    });

    testWidgets("should stay on '/register'", (tester) async {
      // given
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // when
      final context = tester.element(find.byType(RegisterPage));
      GoRouter.of(context).go(LoginRoutes.register.path);
      await tester.pumpAndSettle();

      // then
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });

  group("When user is registered", () {
    final repository = InMemoryPlayerRepository(player: const Player(name: 'Alice'));

    testWidgets("should stay on '/'", (tester) async {
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // then
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RegisterPage), findsNothing);
    });

    testWidgets("should redirect '/register' to '/'", (tester) async {
      // given
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // when
      final context = tester.element(find.byType(HomePage));
      GoRouter.of(context).go(LoginRoutes.register.path);
      await tester.pumpAndSettle();

      // then
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(RegisterPage), findsNothing);
    });

    testWidgets("should stay on '/game'", (tester) async {
      // given
      await tester.pumpWidget(createApp(repository: repository));
      await tester.pumpAndSettle();

      // when
      final context = tester.element(find.byType(HomePage));
      GoRouter.of(context).go(GameRoutes.game.path);
      await tester.pumpAndSettle();

      // then
      expect(find.byType(GamePage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
    });
  });
}
