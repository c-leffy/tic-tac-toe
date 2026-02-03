import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/style/shadow_offset.dart';
import 'package:tic_tac_toe/core/style/size.dart';
import 'package:tic_tac_toe/core/style/theme.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;

  const NeoCard({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.surface,
    this.padding = const EdgeInsets.all(Size.medium),
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: AppColors.border, width: Size.tiny),
      borderRadius: BorderRadius.circular(Size.small),
      boxShadow: [BoxShadow(color: AppColors.shadow, offset: ShadowOffset.offset, blurRadius: 0)],
    ),
    child: child,
  );
}
