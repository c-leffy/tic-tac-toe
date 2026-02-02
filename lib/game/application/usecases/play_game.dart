import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/exception/not_player_turn_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';

class PlayGame {
  final GameRepository _gameRepository;

  const PlayGame(this._gameRepository);

  Future<Game> execute(PlayGameCommand command) async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();
    if (game is! PlayerTurnGame) throw NotPlayerTurnException();

    final updatedGame = game.playAt(x: command.x, y: command.y);

    await _gameRepository.save(updatedGame);
    return updatedGame;
  }
}

class PlayGameCommand {
  final int x;
  final int y;

  PlayGameCommand({this.x = 0, this.y = 0}) : assert(x >= 0 && y >= 0);
}
