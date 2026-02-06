class CellNotAvailableException implements Exception {
  final int x;
  final int y;

  const CellNotAvailableException({required this.x, required this.y});

  @override
  String toString() => 'Cell ($x, $y) is not available';
}
