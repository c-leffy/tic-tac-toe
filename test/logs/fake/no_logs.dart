import 'package:tic_tac_toe/logs/application/ports/logs.dart';

class NoLogs implements Logs {
  const NoLogs();

  @override
  void d(String message, [Map<String, dynamic>? params]) {}

  @override
  void i(String message, [Map<String, dynamic>? params]) {}

  @override
  void w(String message, [Map<String, dynamic>? params]) {}

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {}
}
