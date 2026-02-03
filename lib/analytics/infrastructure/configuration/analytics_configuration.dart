import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/analytics/application/ports/analytics.dart';
import 'package:tic_tac_toe/analytics/infrastructure/adapters/firebase_analytics_adapter.dart';

final analyticsProvider = Provider<Analytics>((ref) => FirebaseAnalyticsAdapter());
