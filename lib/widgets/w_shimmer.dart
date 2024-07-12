import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Color? color;
  final double? height, width;
  final BorderRadius? borderRadius;
  const ShimmerWidget({super.key, this.color, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.hintColor.withOpacity(0.7),
      highlightColor: theme.hintColor.withOpacity(0.2),
      child: SizedBox(
        height: height,
        width: width,
        child: RoundWidget(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          color: theme.hintColor.withOpacity(0.2),
        ),
      ),
    );
  }
}
