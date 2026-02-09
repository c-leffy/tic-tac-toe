import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login/login.dart';

void main() {
  ProviderContainer createContainerWith(PlayerRepository repository) {
    final container = ProviderContainer(
      overrides: [
        playerRepositoryProvider.overrideWith((ref) async => repository),
      ],
    );
    container.listen(registerNotifierProvider, (_, _) {});
    return container;
  }

  ProviderContainer createContainer({Player? player}) {
    return createContainerWith(InMemoryPlayerRepository(player: player));
  }

  test('Initial state should be idle', () {
    // given
    final container = createContainer();

    // when
    final state = container.read(registerNotifierProvider);

    // then
    expect(state, RegisterState.idle);
  });

  test('When registering with a valid name, should transition to registered', () async {
    // given
    final container = createContainer();

    // when
    await container.read(registerNotifierProvider.notifier).register('Alice');

    // then
    expect(container.read(registerNotifierProvider), RegisterState.registered);
  });

  test('When registering with a valid name, should register the player', () async {
    // given
    final repository = InMemoryPlayerRepository();
    final container = createContainerWith(repository);

    // when
    await container.read(registerNotifierProvider.notifier).register('Alice');

    // then
    final player = await repository.get();
    expect(player, const Player(name: 'Alice'));
  });

  test('When registering with an empty name, should show an error', () async {
    // given
    final container = createContainer();

    // when
    await container.read(registerNotifierProvider.notifier).register('');

    // then
    expect(container.read(registerNotifierProvider), RegisterState.invalidName);
  });
}
