import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract interface class NeoAppBar {
  static AppBar build({final VoidCallback? onPressed, final IconData? icon}) => AppBar(
    backgroundColor: AppColors.background,
    toolbarHeight: 60,
    leadingWidth: 60,
    leading: Padding(
      padding: const EdgeInsets.all(Size.small),
      child: icon != null ? NeoButton.icon(icon: icon, onPressed: onPressed) : SizedBox.shrink(),
    ),
  );
}
