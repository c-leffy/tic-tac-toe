abstract interface class Logs {
  void d(String message, [Map<String, dynamic>? params]);
  void i(String message, [Map<String, dynamic>? params]);
  void w(String message, [Map<String, dynamic>? params]);
  void e(String message, [Object? error, StackTrace? stackTrace]);
}
