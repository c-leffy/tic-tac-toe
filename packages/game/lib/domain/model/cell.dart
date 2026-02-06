import 'package:equatable/equatable.dart';
import 'package:game/domain/model/symbol.dart';

class Cell extends Equatable {
  final int x;
  final int y;
  final Symbol symbol;

  const Cell({this.x = 0, this.y = 0, this.symbol = .empty});

  @override
  List<Object?> get props => [x, y, symbol];
}
