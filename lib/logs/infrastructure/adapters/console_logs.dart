import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/logs/application/ports/logs.dart';

class ConsoleLogs implements Logs {
  @override
  void d(String message, [Map<String, dynamic>? params]) =>
      debugPrint('[D] $message${_format(params)}');

  @override
  void i(String message, [Map<String, dynamic>? params]) =>
      debugPrint('[I] $message${_format(params)}');

  @override
  void w(String message, [Map<String, dynamic>? params]) =>
      debugPrint('[W] $message${_format(params)}');

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[E] $message');
    if (error != null) debugPrint('  → $error');
    if (stackTrace != null) debugPrint('$stackTrace');
  }

  String _format(Map<String, dynamic>? params) =>
      params != null ? ' $params' : '';
}
