import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:go_router/go_router.dart';
import 'package:login/login.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(homeNotifierProvider, (_, state) {
      if (state == .gameStarted) {
        context.go(GameRoutes.game.path);
      }
      if (state == .loggedOut) {
        context.go(LoginRoutes.register.path);
      }
    });

    final isLoading = ref.watch(homeNotifierProvider) == .loading;

    return ScrollablePage(
      appBar: NeoAppBar.build(icon: Icons.logout, onPressed: () => _onLogoutPressed(context, ref)),
      children: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Size.large,
          children: [
            _WelcomeText(),
            isLoading
                ? const CircularProgressIndicator()
                : NeoButton.text(label: context.gameL10n.play, onPressed: () => _onPlayPressed(context, ref)),
          ],
        ),
      ),
    );
  }

  Future<void> _onPlayPressed(BuildContext context, WidgetRef ref) async {
    final difficulty = await DifficultyDialog.show(context);
    if (difficulty == null) return;

    ref.read(homeNotifierProvider.notifier).startGame(difficulty);
  }

  Future<void> _onLogoutPressed(BuildContext context, WidgetRef ref) async {
    final homeNotifier = ref.read(homeNotifierProvider.notifier);
    await homeNotifier.logout();
  }
}

class _WelcomeText extends ConsumerWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);

    return Padding(
      padding: const EdgeInsets.all(Size.medium),
      child: Text(
        player.hasValue ? context.gameL10n.welcome(player.value?.name ?? "") : '',
        textAlign: .center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
