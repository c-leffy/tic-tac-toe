import 'package:game/game.dart';
import 'package:go_router/go_router.dart';
import 'package:login/login.dart';

final router = GoRouter(routes: [...gameRoutes, ...loginRoutes]);
