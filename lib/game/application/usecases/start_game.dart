import 'package:analytics/analytics.dart';
import 'package:tic_tac_toe/game/application/ports/game_repository.dart';
import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/state/player_turn_game.dart';

class StartGame {
  final GameRepository _gameRepository;
  final Analytics _analytics;

  const StartGame(this._gameRepository, this._analytics);

  Future<Game> execute(StartGameCommand command) async {
    final game = PlayerTurnGame(board: Board.generate3x3(), difficulty: command.difficulty);
    await _gameRepository.save(game);
    await _analytics.send('game_started', {'difficulty': command.difficulty.name});
    return game;
  }
}

class StartGameCommand {
  final Difficulty difficulty;

  StartGameCommand({required this.difficulty});
}
