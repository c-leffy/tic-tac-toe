import 'package:login/src/application/ports/player_repository.dart';

class Logout {
  final PlayerRepository _repository;

  const Logout(this._repository);

  Future<void> execute() async {
    await _repository.clear();
  }
}
