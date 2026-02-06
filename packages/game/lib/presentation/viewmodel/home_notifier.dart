import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/application/usecases/start_game.dart';
import 'package:game/domain/model/difficulty.dart';
import 'package:game/infrastructure/configuration/game_configuration.dart';

enum HomeState { idle, loading, gameStarted }

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() => HomeState.idle;

  Future<void> startGame(Difficulty difficulty) async {
    state = HomeState.loading;
    await ref.read(startGameUseCaseProvider).execute(StartGameCommand(difficulty: difficulty));
    state = HomeState.gameStarted;
  }
}

final homeNotifierProvider = NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
