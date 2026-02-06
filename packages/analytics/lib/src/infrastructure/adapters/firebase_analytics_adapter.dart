import 'package:analytics/src/application/ports/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsAdapter implements Analytics {
  @override
  Future<void> send(String event, [Map<String, Object>? params]) async {
    await FirebaseAnalytics.instance.logEvent(name: event, parameters: params);
  }
}
