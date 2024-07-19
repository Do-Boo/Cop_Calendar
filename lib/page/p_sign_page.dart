import 'dart:io';

import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_custom_image.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {
    final File image;
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
                    Obx(() {
                      return SizedBox(
                        height: 112,
                        width: 112,
                        child: Button(
                          color: theme.hintColor,
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            await ImagePickerController.to.selectImage();
                          },
                          child: ClipOval(
                            child: FutureBuilder<bool>(
                              future: ImagePickerController.to.isImageExists,
                              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    if (snapshot.data ?? false) {
                                      return Image.file(
                                        height: double.infinity,
                                        width: double.infinity,
                                        File(ImagePickerController.to.selectedImage.path),
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      return const CustomProfile();
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
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
