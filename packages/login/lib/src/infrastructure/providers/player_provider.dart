import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/login.dart';

final playerProvider = FutureProvider.autoDispose((ref) async {
  final getPlayer = await ref.watch(getPlayerUseCaseProvider.future);
  return await getPlayer.execute();
});
