import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:game/game.dart';
import 'package:game/presentation/widgets/game/play_again_button.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) => ScrollablePage(
    appBar: NeoAppBar.build(icon: Icons.home, onPressed: () => context.go(GameRoutes.home.path)),
    children: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Size.medium,
        children: [GameStatusBar(), GameBoard(), PlayAgainButton()],
      ),
    ),
  );
}
