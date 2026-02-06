import 'package:flutter/material.dart';
import 'package:game/domain/model/symbol.dart' as domain;

enum SymbolViewModel {
  x("X", Color(0xFFFE7096)),
  o("O", Color(0xFF2563EB)),
  empty("", Colors.transparent);

  const SymbolViewModel(this.text, this.color);

  final String text;
  final Color color;

  static SymbolViewModel from(domain.Symbol symbol) => switch (symbol) {
    domain.Symbol.x => SymbolViewModel.x,
    domain.Symbol.o => SymbolViewModel.o,
    domain.Symbol.empty => SymbolViewModel.empty,
  };
}
