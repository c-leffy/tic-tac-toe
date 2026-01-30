import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/game/presentation/view/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(title: "Home"),
    ),
  ],
);
