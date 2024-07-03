import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundWidget extends ConsumerWidget {
  final Widget? child;
  final Color? color;
  final double? borderRadius;
  final Border? border;
  final EdgeInsets? padding;
  const RoundWidget({this.padding, this.border, this.color, this.child, this.borderRadius, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.onSecondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        // border: border ?? Border.all(width: 0),
      ),
      child: child ?? const SizedBox(),
    );
  }
}
