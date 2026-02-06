import 'package:login/src/application/ports/player_repository.dart';
import 'package:login/src/domain/model/player.dart';

class InMemoryPlayerRepository implements PlayerRepository {
  Player? _player;

  InMemoryPlayerRepository({Player? player}) : _player = player;

  @override
  Future<void> clear() async {
    _player = null;
  }

  @override
  Future<Player?> get() async => _player;

  @override
  Future<void> save(Player player) async {
    _player = player;
  }
}
