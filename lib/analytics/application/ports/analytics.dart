abstract interface class Analytics {
  void send(String event, [Map<String, Object>? params]);
}
