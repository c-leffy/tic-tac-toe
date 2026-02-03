import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/l10n/core_l10n.dart';
import 'package:tic_tac_toe/core/style/size.dart';
import 'package:tic_tac_toe/core/style/theme.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_status_view_model.dart';

class GameStatusBar extends StatelessWidget {
  final GameStatusViewModel status;

  const GameStatusBar({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Size.large, vertical: Size.medium),
      decoration: BoxDecoration(
        color: status.color,
        border: Border.all(color: AppColors.border, width: Size.tiny),
        borderRadius: BorderRadius.circular(Size.small),
      ),
      child: Text(
        status.message(context.l10n),
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.border),
      ),
    );
  }
}
