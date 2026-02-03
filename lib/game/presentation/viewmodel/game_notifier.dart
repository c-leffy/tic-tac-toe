import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/game/application/usecases/play_game.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/infrastructure/configuration/game_configuration.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_screen_state.dart';
import 'package:tic_tac_toe/game/presentation/viewmodel/game_state_mapper.dart';
import 'package:tic_tac_toe/logs/infrastructure/configuration/logs_configuration.dart';

class GameNotifier extends AsyncNotifier<GameScreenState> {
  @override
  Future<GameScreenState> build() async {
    final repo = ref.read(gameRepositoryProvider);
    final game = await repo.currentGame();
    if (game == null) throw NoGameStartedException();
    return game.toState();
  }

  Future<void> playAgain() async {
    state = const AsyncValue.loading();
    final playAgain = ref.read(playAgainUseCaseProvider);
    state = await AsyncValue.guard(() async {
      final game = await playAgain.execute();
      return game.toState();
    });
  }

  Future<void> play(int x, int y) async {
    final playGame = ref.read(playGameUseCaseProvider);

    try {
      final game = await playGame.execute(PlayGameCommand(x: x, y: y));
      state = AsyncValue.data(game.toState());

      if (state.value is IaTurnScreenState) {
        await _playIa();
      }
    } catch (e) {
      ref.read(logsProvider).e("Error playing: $e");
    }
  }

  Future<void> _playIa() async {
    await Future.delayed(ref.read(iaDelayProvider));
    final playIa = ref.read(playIaUseCaseProvider);

    try {
      final game = await playIa.execute();
      state = AsyncValue.data(game.toState());
    } catch (e) {
      ref.read(logsProvider).e("Error playing IA: $e");
    }
  }
}

final gameNotifierProvider = AsyncNotifierProvider.autoDispose<GameNotifier, GameScreenState>(GameNotifier.new);

final iaDelayProvider = Provider<Duration>((ref) => const Duration(milliseconds: 500));
