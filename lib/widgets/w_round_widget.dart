import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundWidget extends ConsumerWidget {
  final Widget? child;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  const RoundWidget({this.margin, this.padding, this.border, this.color, this.child, this.borderRadius, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding ?? const EdgeInsets.all(8),
      margin: margin ?? const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border ?? const Border(),
      ),
      child: child ?? const SizedBox(),
    );
  }
}
