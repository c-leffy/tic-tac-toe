import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/game/application/usecases/play_game.dart';
import 'package:tic_tac_toe/game/application/usecases/play_ia.dart';
import 'package:tic_tac_toe/game/application/usecases/start_game.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/infrastructure/persistence/inmemory/in_memory_game_repository.dart';

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => InMemoryGameRepository(),
);

final startGameUseCaseProvider = Provider<StartGame>(
  (ref) => StartGame(ref.read(gameRepositoryProvider)),
);

final playGameUseCaseProvider = Provider<PlayGame>(
  (ref) => PlayGame(ref.read(gameRepositoryProvider)),
);

final playIaUseCaseProvider = Provider<PlayIa>(
  (ref) => PlayIa(ref.read(gameRepositoryProvider)),
);
