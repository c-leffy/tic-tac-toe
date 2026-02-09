import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';

class GameStatusBar extends ConsumerWidget {
  const GameStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(gameNotifierProvider.select((it) => GameStatusViewModel.from(it.value)));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Size.large, vertical: Size.medium),
      decoration: BoxDecoration(
        color: status.color,
        border: Border.all(color: AppColors.border, width: Size.tiny),
        borderRadius: BorderRadius.circular(Size.small),
      ),
      child: Text(
        status.message(context.gameL10n),
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.border),
      ),
    );
  }
}
