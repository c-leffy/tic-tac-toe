import 'package:flutter_test/flutter_test.dart';
import 'package:login/login.dart';

void main() {
  test("Should logout", () async {
    // given
    final repository = InMemoryPlayerRepository(player: Player(name: "Alice"));
    final logout = Logout(repository);

    // when
    await logout.execute();

    // then
    final player = await repository.get();
    expect(player, isNull);
  });
}
