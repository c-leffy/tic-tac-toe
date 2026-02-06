import 'dart:math';

import 'package:game/domain/model/board.dart';
import 'package:game/domain/model/cell.dart';
import 'package:game/domain/strategy/ia_strategy.dart';

class RandomStrategy implements IaStrategy {
  final Random _random;

  RandomStrategy({Random? random}) : _random = random ?? Random();

  @override
  Cell chooseCell(Board board) {
    final cells = board.emptyCells.toList();
    return cells[_random.nextInt(cells.length)];
  }
}
