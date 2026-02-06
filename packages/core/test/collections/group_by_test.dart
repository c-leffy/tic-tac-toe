import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('groups elements by key', () {
    // given
    final items = ['apple', 'banana', 'apricot', 'blueberry', 'cherry'];

    // when
    final grouped = items.groupBy((item) => item[0]);

    // then
    expect(grouped, {
      'a': ['apple', 'apricot'],
      'b': ['banana', 'blueberry'],
      'c': ['cherry'],
    });
  });

  test('returns empty map for empty iterable', () {
    // given
    final items = <String>[];

    // when
    final grouped = items.groupBy((item) => item.length);

    // then
    expect(grouped, isEmpty);
  });

  test('groups integers by modulo', () {
    // given
    final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    // when
    final grouped = numbers.groupBy((n) => n % 3);

    // then
    expect(grouped, {
      1: [1, 4, 7],
      2: [2, 5, 8],
      0: [3, 6, 9],
    });
  });

  test('groups objects by property', () {
    // given
    final people = [(name: 'Alice', age: 25), (name: 'Bob', age: 30), (name: 'Charlie', age: 25)];

    // when
    final grouped = people.groupBy((p) => p.age);

    // then
    expect(grouped, {
      25: [(age: 25, name: "Alice"), (age: 25, name: "Charlie")],
      30: [(age: 30, name: "Bob")],
    });
  });
}
