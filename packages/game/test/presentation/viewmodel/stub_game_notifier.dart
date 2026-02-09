import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/presentation/viewmodel/game_notifier.dart';
import 'package:game/presentation/viewmodel/game_screen_state.dart';

class StubGameNotifier extends GameNotifier {
  final AsyncValue<GameScreenState> _state;

  StubGameNotifier(this._state);

  @override
  Future<GameScreenState> build() async => _state.value!;
}
