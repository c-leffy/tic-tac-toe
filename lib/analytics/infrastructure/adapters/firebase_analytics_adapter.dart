import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tic_tac_toe/analytics/application/ports/analytics.dart';

class FirebaseAnalyticsAdapter implements Analytics {
  @override
  Future<void> send(String event, [Map<String, Object>? params]) async {
    await FirebaseAnalytics.instance.logEvent(name: event, parameters: params);
  }
}
