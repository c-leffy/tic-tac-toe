import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/logs/application/ports/logs.dart';
import 'package:tic_tac_toe/logs/infrastructure/adapters/console_logs.dart';

final logsProvider = Provider<Logs>((ref) => ConsoleLogs());
