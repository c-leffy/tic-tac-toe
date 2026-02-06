import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/l10n/game_l10n.dart';
import 'package:game/presentation/viewmodel/home_notifier.dart';
import 'package:game/presentation/widgets/game/difficulty_dialog.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(homeNotifierProvider, (_, state) {
      if (state == HomeState.gameStarted) {
        context.go('/game');
      }
    });

    final isLoading = ref.watch(homeNotifierProvider) == HomeState.loading;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: Size.large,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Image.asset('assets/home.png'),
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : NeoButton.text(
                          label: context.gameL10n.play,
                          onPressed: () => _onPlayPressed(context, ref),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPlayPressed(BuildContext context, WidgetRef ref) async {
    final difficulty = await DifficultyDialog.show(context);
    if (difficulty == null) return;

    ref.read(homeNotifierProvider.notifier).startGame(difficulty);
  }
}
