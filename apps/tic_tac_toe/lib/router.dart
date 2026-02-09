import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/game.dart';
import 'package:go_router/go_router.dart';
import 'package:login/login.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) async {
      final playerRepository = await ref.read(playerRepositoryProvider.future);
      final isRegistered = await playerRepository.isRegistered();
      final isOnRegister = state.matchedLocation == LoginRoutes.register.path;

      if (isRegistered) {
        return isOnRegister ? GameRoutes.home.path : null;
      }
      return isOnRegister ? null : LoginRoutes.register.path;
    },
    routes: [...gameRoutes, ...loginRoutes],
  );
});
