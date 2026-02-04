import 'package:tic_tac_toe/analytics/application/ports/analytics.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/exception/not_ia_turn_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/ia_turn_game.dart';
import 'package:tic_tac_toe/game/domain/strategy/ia_strategy.dart';

class PlayIa {
  final GameRepository _gameRepository;
  final Analytics _analytics;

  const PlayIa(this._gameRepository, this._analytics);

  Future<Game> execute() async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();
    if (game is! IaTurnGame) throw NotIaTurnException();

    final strategy = IaStrategy.from(game.difficulty);
    final cell = strategy.chooseCell(game.board);
    final updatedGame = game.playAt(x: cell.x, y: cell.y);

    await _gameRepository.save(updatedGame);
    await _analytics.send('ia_played', {'x': cell.x, 'y': cell.y});
    return updatedGame;
  }
}
