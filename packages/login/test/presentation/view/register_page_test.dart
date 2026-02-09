import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:login/login.dart';

void main() {
  Widget createWidget() => ProviderScope(
    overrides: [playerRepositoryProvider.overrideWith((ref) async => InMemoryPlayerRepository())],
    child: MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/register',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Home Page')),
          ),
          GoRoute(path: '/register', builder: (_, _) => const RegisterPage()),
        ],
      ),
      localizationsDelegates: const [LoginLocalizations.delegate],
      locale: const Locale('en'),
    ),
  );

  Finder registerButton() => find.widgetWithText(NeoButton, 'Register');

  testWidgets("When 'Register' is pressed with a valid name, should navigate to home page", (tester) async {
    // given
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    // when
    await tester.enterText(find.byType(TextField), 'Alice');
    await tester.scrollUntilVisible(registerButton(), 100, scrollable: find.byType(Scrollable).first);
    await tester.tap(registerButton());
    await tester.pumpAndSettle();

    // then
    expect(find.text('Home Page'), findsOneWidget);
  });

  testWidgets("When 'Register' is pressed with an empty name, should display error message", (tester) async {
    // given
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    // when
    await tester.scrollUntilVisible(registerButton(), 100, scrollable: find.byType(Scrollable).first);
    await tester.tap(registerButton());
    await tester.pumpAndSettle();

    // then
    expect(find.text('Please enter a valid name'), findsOneWidget);
  });
}
