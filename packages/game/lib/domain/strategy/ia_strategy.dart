import 'package:game/domain/model/board.dart';
import 'package:game/domain/model/cell.dart';
import 'package:game/domain/model/difficulty.dart';
import 'package:game/domain/strategy/blocking_strategy.dart';
import 'package:game/domain/strategy/minimax_strategy.dart';
import 'package:game/domain/strategy/random_strategy.dart';

abstract interface class IaStrategy {
  factory IaStrategy.from(Difficulty difficulty) => switch (difficulty) {
    .easy => RandomStrategy(),
    .medium => BlockingStrategy(),
    .difficult => MinimaxStrategy(),
  };

  Cell chooseCell(Board board);
}
