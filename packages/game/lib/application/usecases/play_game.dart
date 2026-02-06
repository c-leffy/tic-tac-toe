import 'package:analytics/analytics.dart';
import 'package:game/application/ports/game_repository.dart';
import 'package:game/domain/exception/no_game_started_exception.dart';
import 'package:game/domain/exception/not_player_turn_exception.dart';
import 'package:game/domain/model/game.dart';
import 'package:game/domain/model/state/player_turn_game.dart';

class PlayGame {
  final GameRepository _gameRepository;
  final Analytics _analytics;

  const PlayGame(this._gameRepository, this._analytics);

  Future<Game> execute(PlayGameCommand command) async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();
    if (game is! PlayerTurnGame) throw NotPlayerTurnException();

    final updatedGame = game.playAt(x: command.x, y: command.y);

    await _gameRepository.save(updatedGame);
    await _analytics.send('player_played', {'x': command.x, 'y': command.y});
    return updatedGame;
  }
}

class PlayGameCommand {
  final int x;
  final int y;

  PlayGameCommand({this.x = 0, this.y = 0}) : assert(x >= 0 && y >= 0);
}
