import 'package:logs/src/application/ports/logs.dart';

class CompositeLogs implements Logs {
  final List<Logs> _loggers;

  const CompositeLogs(this._loggers);

  @override
  void d(String message, [Map<String, dynamic>? params]) {
    for (final logger in _loggers) {
      logger.d(message, params);
    }
  }

  @override
  void i(String message, [Map<String, dynamic>? params]) {
    for (final logger in _loggers) {
      logger.i(message, params);
    }
  }

  @override
  void w(String message, [Map<String, dynamic>? params]) {
    for (final logger in _loggers) {
      logger.w(message, params);
    }
  }

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    for (final logger in _loggers) {
      logger.e(message, error, stackTrace);
    }
  }
}
