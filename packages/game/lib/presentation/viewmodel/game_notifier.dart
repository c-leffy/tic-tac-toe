import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/application/usecases/play_game.dart';
import 'package:game/domain/exception/no_game_started_exception.dart';
import 'package:game/infrastructure/configuration/game_configuration.dart';
import 'package:game/presentation/viewmodel/game_screen_state.dart';
import 'package:game/presentation/viewmodel/game_state_mapper.dart';
import 'package:logs/logs.dart';

class GameNotifier extends AsyncNotifier<GameScreenState> {
  Logs get _logs => ref.read(logsProvider);

  @override
  Future<GameScreenState> build() async {
    final gameRepository = await ref.read(gameRepositoryProvider.future);
    final game = await gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();
    return game.toState();
  }

  Future<void> playAgain() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final playAgain = await ref.read(playAgainUseCaseProvider.future);
      final game = await playAgain.execute();
      return game.toState();
    });
  }

  Future<void> play(int x, int y) async {
    try {
      final playGame = await ref.read(playGameUseCaseProvider.future);
      final game = await playGame.execute(PlayGameCommand(x: x, y: y));
      state = AsyncValue.data(game.toState());

      if (state.value is IaTurnScreenState) {
        await _playIa();
      }
    } catch (e) {
      _logs.e("Error playing: $e");
    }
  }

  Future<void> _playIa() async {
    await Future.delayed(ref.read(iaDelayProvider));
    try {
      final playIa = await ref.read(playIaUseCaseProvider.future);
      final game = await playIa.execute();
      state = AsyncValue.data(game.toState());
    } catch (e) {
      _logs.e("Error playing IA: $e");
    }
  }
}

final gameNotifierProvider = AsyncNotifierProvider.autoDispose<GameNotifier, GameScreenState>(GameNotifier.new);

final iaDelayProvider = Provider<Duration>((ref) => const Duration(milliseconds: 500));
