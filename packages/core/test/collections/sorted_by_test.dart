import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sorts integers in descending order', () {
    // given
    final numbers = [3, 1, 4, 1, 5, 9, 2, 6];

    // when
    final sorted = numbers.sortedByDescending((n) => n);

    // then
    expect(sorted, [9, 6, 5, 4, 3, 2, 1, 1]);
  });

  test('sorts strings by length descending', () {
    // given
    final words = ['a', 'abc', 'ab', 'abcd'];

    // when
    final sorted = words.sortedByDescending((w) => w.length);

    // then
    expect(sorted, ['abcd', 'abc', 'ab', 'a']);
  });

  test('returns empty list for empty iterable', () {
    // given
    final items = <int>[];

    // when
    final sorted = items.sortedByDescending((n) => n);

    // then
    expect(sorted, isEmpty);
  });

  test('does not modify original list', () {
    // given
    final original = [3, 1, 2];

    // when
    final sorted = original.sortedByDescending((n) => n);

    // then
    expect(original, [3, 1, 2]);
    expect(sorted, [3, 2, 1]);
  });

  test('sorts objects by property', () {
    // given
    final people = [(name: 'Alice', age: 25), (name: 'Bob', age: 30), (name: 'Charlie', age: 20)];

    // when
    final sorted = people.sortedByDescending((p) => p.age);

    // then
    expect(sorted.map((p) => p.name).toList(), ['Bob', 'Alice', 'Charlie']);
  });
}
