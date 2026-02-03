import 'package:tic_tac_toe/analytics/application/ports/analytics.dart';

class NoAnalytics implements Analytics {
  const NoAnalytics();

  @override
  void send(String event, [Map<String, Object>? params]) {}
}
