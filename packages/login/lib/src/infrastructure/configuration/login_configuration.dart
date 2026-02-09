import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/src/application/ports/player_repository.dart';
import 'package:login/src/application/usecases/logout.dart';
import 'package:login/src/application/usecases/register_player.dart';
import 'package:login/src/infrastructure/persistence/sharedpreferences/shared_preferences_player_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final playerRepositoryProvider = FutureProvider<PlayerRepository>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SharedPreferencesPlayerRepository(prefs);
});

final registerPlayerUseCaseProvider = FutureProvider<RegisterPlayer>((ref) async {
  final repository = await ref.watch(playerRepositoryProvider.future);
  return RegisterPlayer(repository);
});

final logoutUseCaseProvider = FutureProvider<Logout>((ref) async {
  final repository = await ref.watch(playerRepositoryProvider.future);
  return Logout(repository);
});
