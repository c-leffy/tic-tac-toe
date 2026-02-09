import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/l10n/game_l10n.dart';
import 'package:game/presentation/viewmodel/game_notifier.dart';

class PlayAgainButton extends ConsumerWidget {
  const PlayAgainButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGameOver = ref.watch(gameNotifierProvider.select((it) => it.value?.isGameOver ?? false));

    return Visibility(
      visible: isGameOver,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Size.large),
        child: NeoButton.text(
          label: context.gameL10n.playAgain,
          onPressed: () => ref.read(gameNotifierProvider.notifier).playAgain(),
        ),
      ),
    );
  }
}
