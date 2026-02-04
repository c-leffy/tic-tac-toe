abstract interface class Analytics {
  Future<void> send(String event, [Map<String, Object>? params]);
}
