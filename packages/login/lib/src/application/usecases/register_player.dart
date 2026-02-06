import 'package:login/src/application/ports/player_repository.dart';
import 'package:login/src/domain/exception/invalid_name_exception.dart';
import 'package:login/src/domain/model/player.dart';

class RegisterCommand {
  final String name;

  const RegisterCommand({required this.name});
}

class RegisterPlayer {
  final PlayerRepository _repository;

  const RegisterPlayer(this._repository);

  Future<Player> execute(RegisterCommand command) async {
    final name = command.name.trim();

    if (name.isEmpty) {
      throw const InvalidNameException();
    }

    final player = Player(name: name);
    await _repository.save(player);
    return player;
  }
}
