import 'package:events_app/widgets/w_button.dart';
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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 72, child: Placeholder()),
              const SizedBox(height: 16),
              const SizedBox(
                height: 24,
                width: double.infinity,
                child: Text(
                  "Pages",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                child: RoundButton(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                  border: 1 == 1 ? Border.all(width: 1) : const Border(),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text("asdf"),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: RoundButton(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                  border: const Border(),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text("asdf"),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: RoundButton(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                  border: const Border(),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text("asdf"),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: RoundButton(
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                  border: const Border(),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text("asdf"),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const SizedBox(
                height: 24,
                width: double.infinity,
                child: Text(
                  "Config",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 56, child: Placeholder()),
              const SizedBox(height: 8),
              const SizedBox(height: 56, child: Placeholder()),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
