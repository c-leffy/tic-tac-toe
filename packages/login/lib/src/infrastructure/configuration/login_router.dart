import 'package:go_router/go_router.dart';
import 'package:login/src/presentation/view/register_page.dart';

final loginRoutes = [GoRoute(path: LoginRoutes.register.path, builder: (context, state) => const RegisterPage())];

enum LoginRoutes {
  register("/register");

  const LoginRoutes(this.path);

  final String path;
}
