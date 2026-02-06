import 'package:analytics/src/application/ports/analytics.dart';
import 'package:analytics/src/infrastructure/adapters/firebase_analytics_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsProvider = Provider<Analytics>((ref) => FirebaseAnalyticsAdapter());
