import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/login.dart';

final playerProvider = FutureProvider.autoDispose((ref) async {
  final playerRepository = await ref.watch(playerRepositoryProvider.future);
  return await playerRepository.get();
});
