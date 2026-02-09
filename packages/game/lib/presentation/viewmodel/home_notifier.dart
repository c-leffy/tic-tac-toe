import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/application/usecases/start_game.dart';
import 'package:game/domain/model/difficulty.dart';
import 'package:game/infrastructure/configuration/game_configuration.dart';
import 'package:login/login.dart';

enum HomeState { idle, loading, gameStarted, loggedOut }

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() => HomeState.idle;

  Future<void> startGame(Difficulty difficulty) async {
    state = HomeState.loading;
    final startGame = await ref.read(startGameUseCaseProvider.future);
    await startGame.execute(StartGameCommand(difficulty: difficulty));
    state = HomeState.gameStarted;
  }

  Future<void> logout() async {
    state = HomeState.loading;
    final logout = await ref.read(logoutUseCaseProvider.future);
    await logout.execute();
    state = HomeState.loggedOut;
  }
}

final homeNotifierProvider = NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
