import 'stub_game_notifier.dart';

class SpyGameNotifier extends StubGameNotifier {
  final List<(int, int)> playCalls = [];

  SpyGameNotifier(super.state);

  @override
  Future<void> play(int x, int y) async => playCalls.add((x, y));
}
