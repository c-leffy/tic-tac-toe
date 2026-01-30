import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/repository/game_repository.dart';

class PlayGame {
  final GameRepository _gameRepository;

  const PlayGame(this._gameRepository);

  Future<Game> execute(PlayGameCommand command) async {
    final currentGame = await _gameRepository.currentGame();
    if (currentGame == null) {
      throw NoGameStartedException();
    }
    final updatedGame = currentGame.playAt(x: command.x, y: command.y, symbol: .x);
    await _gameRepository.save(updatedGame);
    return updatedGame;
  }
}

class PlayGameCommand {
  final int x;
  final int y;

  PlayGameCommand({this.x = 0, this.y = 0}) : assert(x >= 0 && y >= 0);
}
