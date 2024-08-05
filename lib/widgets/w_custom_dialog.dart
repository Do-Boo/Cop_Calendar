import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;

  const CustomDialogWidget({super.key, this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
          height: 216,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.hintColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
