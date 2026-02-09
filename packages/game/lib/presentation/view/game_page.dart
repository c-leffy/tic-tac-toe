import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:go_router/go_router.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameNotifierProvider);

    return ScrollablePage(
      appBar: NeoAppBar.build(icon: Icons.home, onPressed: () => context.go('/')),
      children: gameState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(error: error),
        data: (state) => _GameContent(state: state),
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
          Text(context.coreL10n.error(error.toString()), style: Theme.of(context).textTheme.bodyLarge),
          NeoButton.text(
            label: context.coreL10n.backToHome,
            backgroundColor: AppColors.secondary,
            onPressed: () => context.go(GameRoutes.home.path),
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
  Widget build(BuildContext context, WidgetRef ref) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Size.medium,
      children: [
        GameStatusBar(status: GameStatusViewModel.from(state)),
        GameBoard(
          board: state.board,
          isPlayerTurn: state.isPlayerTurn,
          onCellTap: state.isPlayerTurn ? (x, y) => ref.read(gameNotifierProvider.notifier).play(x, y) : null,
        ),
        Visibility(
          visible: state.isGameOver,
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
        ),
      ],
    ),
  );
}
