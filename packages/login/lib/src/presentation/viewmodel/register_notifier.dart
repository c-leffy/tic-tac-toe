import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/src/application/usecases/register_player.dart';
import 'package:login/src/domain/exception/invalid_name_exception.dart';
import 'package:login/src/infrastructure/configuration/login_configuration.dart';

enum RegisterState { idle, loading, registered, invalidName }

class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() => RegisterState.idle;

  Future<void> register(String name) async {
    state = RegisterState.loading;
    try {
      final useCase = await ref.read(registerPlayerUseCaseProvider.future);
      await useCase.execute(RegisterCommand(name: name));
      state = RegisterState.registered;
    } on InvalidNameException {
      state = RegisterState.invalidName;
    }
  }
}

final registerNotifierProvider = NotifierProvider<RegisterNotifier, RegisterState>(RegisterNotifier.new);
