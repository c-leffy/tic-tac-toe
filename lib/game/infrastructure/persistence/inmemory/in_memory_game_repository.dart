import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';

class InMemoryGameRepository implements GameRepository {
  Game? _game;

  InMemoryGameRepository({Game? game}) : _game = game;

  @override
  Future<Game?> currentGame() async => _game;

  @override
  Future<void> save(Game game) async {
    _game = game;
  }
}
