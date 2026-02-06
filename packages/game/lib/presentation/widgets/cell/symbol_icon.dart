import 'package:flutter/material.dart';
import 'package:game/presentation/viewmodel/symbol_view_model.dart';

class SymbolIcon extends StatelessWidget {
  final SymbolViewModel symbol;

  const SymbolIcon({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      symbol.text,
      style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: symbol.color),
    ),
  );
}
