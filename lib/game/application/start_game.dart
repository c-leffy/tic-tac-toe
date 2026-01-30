import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/model/game.dart';
import 'package:tic_tac_toe/game/domain/model/player.dart';
import 'package:tic_tac_toe/game/domain/repository/game_repository.dart';

class StartGame {
  final GameRepository _gameRepository;

  const StartGame(this._gameRepository);

  Future<Game> execute(StartGameCommand command) async {
    final game = Game(
      board: Board.generate3x3(),
      player: Player.player("Guest"),
      ia: Player.ia(),
      difficulty: command.difficulty,
    );
    await _gameRepository.save(game);
    return game;
  }
}

class StartGameCommand {
  final Difficulty difficulty;

  StartGameCommand({required this.difficulty});
}
