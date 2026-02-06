import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:tic_tac_toe/l10n/l10n_extensions.dart';
import 'package:tic_tac_toe/game/presentation/l10n/game_l10n.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/home_notifier.dart';
import 'package:tic_tac_toe/game/presentation/widgets/game/difficulty_dialog.dart';

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
                      : NeoButton.text(label: context.l10n.play, onPressed: () => _onPlayPressed(context, ref)),
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
