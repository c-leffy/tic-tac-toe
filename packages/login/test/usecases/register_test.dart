import 'package:flutter_test/flutter_test.dart';
import 'package:login/login.dart';

void main() {
  test("Trim player's name when register", () async {
    // given
    final repository = InMemoryPlayerRepository();
    final register = RegisterPlayer(repository);

    // when
    final player = await register.execute(const RegisterCommand(name: '  Alice  '));

    // then
    expect(player.name, 'Alice');
    final savedPlayer = await repository.get();
    expect(savedPlayer?.name, 'Alice');
  });

  test("Can't register with an empty name", () async {
    // given
    final register = RegisterPlayer(InMemoryPlayerRepository());

    // when / then
    expect(() => register.execute(const RegisterCommand(name: '')), throwsA(isA<InvalidNameException>()));
  });

  test("Can't register with a blank name", () async {
    // given
    final register = RegisterPlayer(InMemoryPlayerRepository());

    // when / then
    expect(() => register.execute(const RegisterCommand(name: '   ')), throwsA(isA<InvalidNameException>()));
  });
}
