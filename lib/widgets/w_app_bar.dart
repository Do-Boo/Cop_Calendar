import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppBar extends ConsumerWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      height: 72,
      child: Row(
        children: [
          const Expanded(
            flex: 5,
            child: RoundWidget(
              child: Text('Hello, World!'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              flex: 1,
              child: RoundButton(
                onPressed: () => {},
                child: Text("Add Contents +", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16)),
              )),
          const SizedBox(width: 16),
          const SizedBox(
            width: 40,
            child: RoundWidget(
              child: Text('A'),
            ),
          ),
          const SizedBox(width: 16),
          const SizedBox(
            width: 40,
            child: RoundWidget(
              child: Text('B'),
            ),
          ),
        ],
      ),
    );
  }
}
