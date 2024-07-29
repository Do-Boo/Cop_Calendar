import 'package:events_app/api/v_model.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewModel viewModel = ViewModel();
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Button(
                    color: Colors.transparent,
                    onPressed: () async {
                      if (AuthController.to.isLoggedIn) {
                        await viewModel.logout();
                      } else {
                        await viewModel.login();
                      }
                      HapticFeedback.lightImpact();
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 54,
                          width: 54,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              AuthController.to.profile,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(AuthController.to.nickName, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Button(
                      color: Colors.transparent,
                      onPressed: () async {
                        HapticFeedback.lightImpact();
                      },
                      child: const Icon(Icons.settings, size: 28),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
