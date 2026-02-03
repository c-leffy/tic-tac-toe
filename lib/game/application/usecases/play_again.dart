import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/application/usecases/start_game.dart';
import 'package:tic_tac_toe/game/domain/exception/no_game_started_exception.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';

class PlayAgainGame {
  final GameRepository _gameRepository;
  final StartGame _startGame;

  PlayAgainGame(this._gameRepository) : _startGame = StartGame(_gameRepository);

  Future<Game> execute() async {
    final game = await _gameRepository.currentGame();
    if (game == null) throw NoGameStartedException();

    final newGame = await _startGame.execute(StartGameCommand(difficulty: game.difficulty));
    await _gameRepository.save(newGame);
    return newGame;
  }
}
