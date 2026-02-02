import 'package:tic_tac_toe/game/domain/model/board.dart';
import 'package:tic_tac_toe/game/domain/model/cell.dart';
import 'package:tic_tac_toe/game/domain/model/difficulty.dart';
import 'package:tic_tac_toe/game/domain/strategy/blocking_strategy.dart';
import 'package:tic_tac_toe/game/domain/strategy/minimax_strategy.dart';
import 'package:tic_tac_toe/game/domain/strategy/random_strategy.dart';

abstract interface class IaStrategy {
  factory IaStrategy.from(Difficulty difficulty) => switch (difficulty) {
    .easy => RandomStrategy(),
    .medium => BlockingStrategy(),
    .difficult => MinimaxStrategy(),
  };

  Cell chooseCell(Board board);
}
