import 'package:flutter_test/flutter_test.dart';
import 'package:logs/logs.dart';

import 'spy_logs.dart';

void main() {
  test('d() delegates to all loggers', () {
    // given
    final logger1 = SpyLogs();
    final logger2 = SpyLogs();
    final composite = CompositeLogs([logger1, logger2]);

    // when
    composite.d('debug message');

    // then
    expect(logger1.debugMessages, ['debug message']);
    expect(logger2.debugMessages, ['debug message']);
  });

  test('i() delegates to all loggers', () {
    // given
    final logger1 = SpyLogs();
    final logger2 = SpyLogs();
    final composite = CompositeLogs([logger1, logger2]);

    // when
    composite.i('info message');

    // then
    expect(logger1.infoMessages, ['info message']);
    expect(logger2.infoMessages, ['info message']);
  });

  test('w() delegates to all loggers', () {
    // given
    final logger1 = SpyLogs();
    final logger2 = SpyLogs();
    final composite = CompositeLogs([logger1, logger2]);

    // when
    composite.w('warning message');

    // then
    expect(logger1.warningMessages, ['warning message']);
    expect(logger2.warningMessages, ['warning message']);
  });

  test('e() delegates to all loggers', () {
    // given
    final logger1 = SpyLogs();
    final logger2 = SpyLogs();
    final composite = CompositeLogs([logger1, logger2]);

    // when
    composite.e('error message', Exception('test'), StackTrace.empty);

    // then
    expect(logger1.errorMessages, ['error message']);
    expect(logger2.errorMessages, ['error message']);
  });

  test('works with empty list of loggers', () {
    // given
    const composite = CompositeLogs([]);

    // when / then
    expect(() => composite.d('message'), returnsNormally);
    expect(() => composite.i('message'), returnsNormally);
    expect(() => composite.w('message'), returnsNormally);
    expect(() => composite.e('message'), returnsNormally);
  });

  test('delegates multiple calls in order', () {
    // given
    final logger = SpyLogs();
    final composite = CompositeLogs([logger]);

    // when
    composite.d('first');
    composite.d('second');
    composite.i('third');

    // then
    expect(logger.debugMessages, ['first', 'second']);
    expect(logger.infoMessages, ['third']);
  });
}
