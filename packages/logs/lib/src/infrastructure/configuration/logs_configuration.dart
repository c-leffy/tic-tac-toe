import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logs/src/application/ports/logs.dart';
import 'package:logs/src/infrastructure/adapters/console_logs.dart';

final logsProvider = Provider<Logs>((ref) => ConsoleLogs());
