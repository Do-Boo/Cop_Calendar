import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final Widget? child;
  final double? borderRadius;
  final Border? border;

  const Button({super.key, this.color, this.border, this.child, this.borderRadius, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? theme.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 128),
          border: border ?? const Border(),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 128),
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
