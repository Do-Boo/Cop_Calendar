import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideMenuBar extends ConsumerWidget {
  const SideMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 216,
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
        child: const Placeholder(),
      ),
    );
  }
}
