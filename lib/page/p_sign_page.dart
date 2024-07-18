import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 56,
              width: double.infinity,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Button(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Button(
                        child: const Icon(Icons.close),
                        onPressed: () => {
                          Navigator.of(context).pop(),
                          HapticFeedback.lightImpact(),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  children: [
                    const Text("Sign in", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 32),
                    RoundWidget(
                      color: theme.hintColor,
                      child: SizedBox(
                        height: 72,
                        width: 72,
                        child: Button(
                          color: theme.hintColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RoundWidget(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      borderRadius: BorderRadius.circular(18),
                      color: theme.hintColor.withOpacity(0.1),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "닉네임",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    RoundWidget(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      borderRadius: BorderRadius.circular(18),
                      color: theme.hintColor.withOpacity(0.1),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "닉네임",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
