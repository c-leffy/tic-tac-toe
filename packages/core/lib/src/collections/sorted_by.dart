extension SortedByExtension<T> on Iterable<T> {
  List<T> sortedByDescending<K extends Comparable<K>>(K Function(T) keyOf) =>
      toList()..sort((a, b) => keyOf(b).compareTo(keyOf(a)));
}
