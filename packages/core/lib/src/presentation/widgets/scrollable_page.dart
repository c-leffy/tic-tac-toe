import 'package:flutter/material.dart';

class ScrollablePage extends StatelessWidget {
  final AppBar appBar;
  final Widget children;

  const ScrollablePage({super.key, required this.appBar, required this.children});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: children,
          ),
        ),
      ),
    ),
  );
}
