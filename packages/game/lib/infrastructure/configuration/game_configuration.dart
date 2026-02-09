import 'package:analytics/analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/application/ports/game_repository.dart';
import 'package:game/application/usecases/play_again.dart';
import 'package:game/application/usecases/play_game.dart';
import 'package:game/application/usecases/play_ia.dart';
import 'package:game/application/usecases/start_game.dart';
import 'package:game/infrastructure/persistence/inmemory/in_memory_game_repository.dart';

final gameRepositoryProvider = FutureProvider<GameRepository>((ref) async => InMemoryGameRepository());

final startGameUseCaseProvider = FutureProvider<StartGame>((ref) async {
  final repository = await ref.watch(gameRepositoryProvider.future);
  return StartGame(repository, ref.watch(analyticsProvider));
});

final playAgainUseCaseProvider = FutureProvider<PlayAgainGame>((ref) async {
  final repository = await ref.watch(gameRepositoryProvider.future);
  return PlayAgainGame(repository, ref.watch(analyticsProvider));
});

final playGameUseCaseProvider = FutureProvider<PlayGame>((ref) async {
  final repository = await ref.watch(gameRepositoryProvider.future);
  return PlayGame(repository, ref.watch(analyticsProvider));
});

final playIaUseCaseProvider = FutureProvider<PlayIa>((ref) async {
  final repository = await ref.watch(gameRepositoryProvider.future);
  return PlayIa(repository, ref.watch(analyticsProvider));
});
