import 'package:logs/logs.dart';

class SpyLogs implements Logs {
  final List<String> debugMessages = [];
  final List<String> infoMessages = [];
  final List<String> warningMessages = [];
  final List<String> errorMessages = [];

  @override
  void d(String message, [Map<String, dynamic>? params]) {
    debugMessages.add(message);
  }

  @override
  void i(String message, [Map<String, dynamic>? params]) {
    infoMessages.add(message);
  }

  @override
  void w(String message, [Map<String, dynamic>? params]) {
    warningMessages.add(message);
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    errorMessages.add(message);
  }
}
