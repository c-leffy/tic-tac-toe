import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String name;

  const Player({required this.name});

  @override
  List<Object?> get props => [name];
}
