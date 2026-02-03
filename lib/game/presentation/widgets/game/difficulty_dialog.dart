import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/l10n/core_l10n.dart';
import 'package:tic_tac_toe/core/presentation/widgets/neo_button.dart';
import 'package:tic_tac_toe/core/style/size.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/presentation/l10n/game_l10n.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/difficulty_view_model.dart';

class DifficultyDialog extends StatelessWidget {
  const DifficultyDialog({super.key});

  static Future<Difficulty?> show(BuildContext context) =>
      showDialog<Difficulty>(context: context, builder: (_) => const DifficultyDialog());

  @override
  Widget build(BuildContext context) => AlertDialog(
    elevation: 0,
    title: Text(context.l10n.chooseDifficulty),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Size.medium,
      children: DifficultyViewModel.all.map(_DifficultyButton.new).toList(),
    ),
  );
}

class _DifficultyButton extends StatelessWidget {
  const _DifficultyButton(this._viewModel);

  final DifficultyViewModel _viewModel;

  @override
  Widget build(BuildContext context) => NeoButton.text(
    label: _viewModel.label(context.l10n),
    backgroundColor: _viewModel.color,
    width: 200,
    onPressed: () => Navigator.pop(context, _viewModel.toDomain()),
  );
}
