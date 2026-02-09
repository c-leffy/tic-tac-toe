import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:login/l10n/login_l10n.dart';
import 'package:login/src/presentation/viewmodel/register_notifier.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerNotifierProvider, (_, state) {
      if (state == .registered) {
        context.go("/");
      }
    });

    return ScrollablePage(
      appBar: NeoAppBar.build(),
      children: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Size.large,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Image.asset('assets/home.png', package: 'login'),
            ),
            const _RegisterForm(),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerStatefulWidget {
  const _RegisterForm();

  @override
  ConsumerState<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<_RegisterForm> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerNotifierProvider);
    final errorText = state == .invalidName ? context.loginL10n.invalidName : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: Size.large,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(Size.medium),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: context.loginL10n.nameHint,
                errorText: errorText,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        state == .loading
            ? const CircularProgressIndicator()
            : NeoButton.text(label: context.loginL10n.register, onPressed: () => _onRegisterPressed()),
      ],
    );
  }

  Future<void> _onRegisterPressed() async {
    final registerNotifier = ref.read(registerNotifierProvider.notifier);
    await registerNotifier.register(_nameController.text);
  }
}
