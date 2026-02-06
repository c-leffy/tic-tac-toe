import 'package:core/src/style/shadow_offset.dart';
import 'package:core/src/style/size.dart';
import 'package:core/src/style/theme.dart';
import 'package:flutter/material.dart';

class NeoButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final EdgeInsets padding;
  final double? width;

  const NeoButton._({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Size.large,
      vertical: Size.medium,
    ),
    this.width,
  });

  factory NeoButton.text({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    Color backgroundColor = AppColors.primary,
    Color textColor = AppColors.border,
    double? width,
  }) => NeoButton._(
    key: key,
    onPressed: onPressed,
    backgroundColor: backgroundColor,
    width: width,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );

  factory NeoButton.icon({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    Color backgroundColor = AppColors.surface,
    Color iconColor = AppColors.border,
    double size = 24,
  }) => NeoButton._(
    key: key,
    onPressed: onPressed,
    backgroundColor: backgroundColor,
    padding: const EdgeInsets.all(Size.small),
    child: Icon(icon, size: size, color: iconColor),
  );

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final offset = _isPressed ? Offset.zero : ShadowOffset.offset;

    return GestureDetector(
      onTapDown: widget.onPressed != null ? _onTapDown : null,
      onTapUp: widget.onPressed != null ? _onTapUp : null,
      onTapCancel: widget.onPressed != null ? _onTapCancel : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(
          _isPressed ? ShadowOffset.x : 0,
          _isPressed ? ShadowOffset.y : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: AppColors.border, width: Size.tiny),
          borderRadius: BorderRadius.circular(Size.small),
          boxShadow: [
            BoxShadow(color: AppColors.shadow, offset: offset, blurRadius: 0),
          ],
        ),
        child: Container(
          width: widget.width,
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
