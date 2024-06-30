import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundWidget extends ConsumerWidget {
  final Widget child;
  final double radius;
  const RoundWidget({required this.child, required this.radius, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
