import 'package:events_app/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialogWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? content;
  final VoidCallback? onPressed;

  const CustomDialogWidget({super.key, this.child, this.title, this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: Colors.transparent,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? "Title", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Text(
                    content ?? "Content",
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  onPressed != null
                      ? SizedBox(
                          height: 40,
                          width: 88,
                          child: Button(
                            color: Colors.transparent,
                            border: Border.all(color: theme.hintColor.withOpacity(0.4)),
                            onPressed: onPressed ?? () {},
                            child: const Text("확인", style: TextStyle(fontSize: 16)),
                          ),
                        )
                      : const SizedBox(),
                  onPressed != null ? const SizedBox(width: 24) : const SizedBox(),
                  SizedBox(
                    height: 40,
                    width: 88,
                    child: Button(
                      color: Colors.transparent,
                      border: Border.all(color: theme.hintColor.withOpacity(0.4)),
                      child: const Text("닫기", style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        Navigator.pop(context);
                        HapticFeedback.lightImpact();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
