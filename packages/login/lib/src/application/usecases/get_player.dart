import 'package:login/src/application/ports/player_repository.dart';
import 'package:login/src/domain/model/player.dart';

class GetPlayer {
  final PlayerRepository _repository;

  const GetPlayer(this._repository);

  Future<Player?> execute() async {
    return await _repository.get();
  }
}
