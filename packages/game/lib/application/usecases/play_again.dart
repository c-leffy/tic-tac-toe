import 'package:analytics/analytics.dart';
import 'package:game/application/ports/game_repository.dart';
import 'package:game/application/usecases/start_game.dart';
import 'package:game/domain/exception/no_game_started_exception.dart';
import 'package:game/domain/model/game.dart';

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
    await _analytics.send('play_again', {'difficulty': game.difficulty.name});
    return newGame;
  }
}
