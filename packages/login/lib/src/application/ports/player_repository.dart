import 'package:login/src/domain/model/player.dart';

abstract interface class PlayerRepository {
  Future<Player?> get();

  Future<bool> isRegistered();

  Future<void> save(Player player);

  Future<void> clear();
}
