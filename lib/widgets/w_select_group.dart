import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectGroup extends ConsumerWidget {
  const SelectGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 104,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 32,
                  child: const Text("Test", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40, child: RoundWidget()),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 32,
                  child: const Text("Test", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40, child: RoundWidget()),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 32,
                  child: const Text("Test", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 40, child: RoundWidget()),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              children: [
                SizedBox(height: 32, child: SizedBox()),
                SizedBox(height: 40, child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
