import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;

  const RoundButton({
    super.key,
    this.color,
    required this.child,
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
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          border: Border.all(width: 1),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius ?? 5),
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
