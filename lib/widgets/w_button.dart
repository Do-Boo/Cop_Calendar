import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final Widget? child;
  final double? borderRadius;
  final Border? border;

  const RoundButton({
    super.key,
    this.color,
    this.border,
    this.child,
    this.borderRadius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border ?? Border.all(width: 1),
        ),
        child: InkWell(
          onTap: onPressed ?? () => print("object"),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
