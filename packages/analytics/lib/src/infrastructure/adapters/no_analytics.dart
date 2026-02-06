import 'package:analytics/src/application/ports/analytics.dart';

/// A no-op implementation of [Analytics] for testing or when analytics
/// should be disabled.
class NoAnalytics implements Analytics {
  const NoAnalytics();

  @override
  Future<void> send(String event, [Map<String, Object>? params]) async {}
}
