import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/src/application/ports/player_repository.dart';
import 'package:login/src/application/usecases/logout.dart';
import 'package:login/src/application/usecases/register_player.dart';
import 'package:login/src/infrastructure/persistence/inmemory/in_memory_player_repository.dart';

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return InMemoryPlayerRepository();
});

final registerPlayerUseCaseProvider = Provider<RegisterPlayer>((ref) {
  return RegisterPlayer(ref.watch(playerRepositoryProvider));
});

final logoutUseCaseProvider = Provider<Logout>((ref) {
  return Logout(ref.watch(playerRepositoryProvider));
});
