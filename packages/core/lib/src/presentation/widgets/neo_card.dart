import 'package:core/src/style/shadow_offset.dart';
import 'package:core/src/style/size.dart';
import 'package:core/src/style/theme.dart';
import 'package:flutter/material.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final double width;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;

  const NeoCard({
    super.key,
    required this.child,
    required this.width,
    this.backgroundColor = AppColors.surface,
    this.padding = const EdgeInsets.all(Size.medium),
  });

  @override
  Widget build(BuildContext context) => Container(
    width: width,
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
