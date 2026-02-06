import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:tic_tac_toe/l10n/l10n_extensions.dart';
import 'package:tic_tac_toe/game/presentation/l10n/game_l10n.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_notifier.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_screen_state.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_status_view_model.dart';
import 'package:tic_tac_toe/game/presentation/widgets/board/game_board.dart';
import 'package:tic_tac_toe/game/presentation/widgets/game/game_status_bar.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: gameState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => _ErrorView(error: error),
                data: (state) => _GameContent(state: state),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Object error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(Size.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Size.medium,
        children: [
          Text(context.l10n.error(error.toString()), style: Theme.of(context).textTheme.bodyLarge),
          NeoButton.text(
            label: context.l10n.backToHome,
            backgroundColor: AppColors.secondary,
            onPressed: () => context.go('/'),
          ),
        ],
      ),
    ),
  );
}

class _GameContent extends ConsumerWidget {
  final GameScreenState state;

  const _GameContent({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: Size.medium, top: Size.small),
          child: NeoButton.icon(icon: Icons.home, onPressed: () => context.go('/')),
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Size.medium,
        children: [
          GameStatusBar(status: GameStatusViewModel.from(state)),
          GameBoard(
            board: state.board,
            isPlayerTurn: state.isPlayerTurn,
            onCellTap: state.isPlayerTurn ? (x, y) => ref.read(gameNotifierProvider.notifier).play(x, y) : null,
          ),
        ],
      ),
      Visibility(
        visible: state.isGameOver,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: Size.large),
          child: NeoButton.text(
            label: context.l10n.playAgain,
            onPressed: () => ref.read(gameNotifierProvider.notifier).playAgain(),
          ),
        ),
      ),
    ],
  );
}
