extension IterableExtension<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      map.putIfAbsent(keySelector(element), () => []).add(element);
    }
    return map;
  }
}
