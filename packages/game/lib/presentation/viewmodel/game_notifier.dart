import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/application/ports/game_repository.dart';
import 'package:game/application/usecases/play_again.dart';
import 'package:game/application/usecases/play_game.dart';
import 'package:game/application/usecases/play_ia.dart';
import 'package:game/domain/exception/no_game_started_exception.dart';
import 'package:game/infrastructure/configuration/game_configuration.dart';
import 'package:game/presentation/viewmodel/game_screen_state.dart';
import 'package:game/presentation/viewmodel/game_state_mapper.dart';
import 'package:logs/logs.dart';

class GameNotifier extends AsyncNotifier<GameScreenState> {
  GameRepository get _gameRepository => ref.read(gameRepositoryProvider);

  PlayAgainGame get _playAgainUseCase => ref.read(playAgainUseCaseProvider);

  PlayGame get _playUseCase => ref.read(playGameUseCaseProvider);

  PlayIa get _playIaUseCase => ref.read(playIaUseCaseProvider);

  Logs get _logs => ref.read(logsProvider);

  @override
  Future<GameScreenState> build() async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();
    return game.toState();
  }

  Future<void> playAgain() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final game = await _playAgainUseCase.execute();
      return game.toState();
    });
  }

  Future<void> play(int x, int y) async {
    try {
      final game = await _playUseCase.execute(PlayGameCommand(x: x, y: y));
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
      final game = await _playIaUseCase.execute();
      state = AsyncValue.data(game.toState());
    } catch (e) {
      _logs.e("Error playing IA: $e");
    }
  }
}

final gameNotifierProvider = AsyncNotifierProvider.autoDispose<GameNotifier, GameScreenState>(GameNotifier.new);

final iaDelayProvider = Provider<Duration>((ref) => const Duration(milliseconds: 500));
