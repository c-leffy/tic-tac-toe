import 'package:logs/src/application/ports/logs.dart';

/// A no-op implementation of [Logs] for testing or when logging
/// should be disabled.
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
