import 'package:tic_tac_toe/analytics/application/ports/analytics.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/application/usecases/start_game.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';

class PlayAgainGame {
  final GameRepository _gameRepository;
  final Analytics _analytics;
  final StartGame _startGame;

  PlayAgainGame(this._gameRepository, this._analytics) : _startGame = StartGame(_gameRepository, _analytics);

  Future<Game> execute() async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();

    final newGame = await _startGame.execute(StartGameCommand(difficulty: game.difficulty));
    await _gameRepository.save(newGame);
    _analytics.send('play_again', {'difficulty': game.difficulty.name});
    return newGame;
  }
}
