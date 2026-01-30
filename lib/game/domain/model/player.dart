import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/game/domain/model/symbol.dart';

class Player extends Equatable {
  final String name;
  final Symbol symbol;

  const Player(this.name, this.symbol);

  factory Player.ia() => Player("IA", .o);

  factory Player.player(String name) => Player(name, .x);

  @override
  List<Object?> get props => [name, symbol];
}
