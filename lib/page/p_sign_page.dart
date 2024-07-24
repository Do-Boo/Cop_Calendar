import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:events_app/function/f_phone_number_format.dart';
import 'package:events_app/api/api_database_query.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_custom_dialog.dart';
import 'package:events_app/widgets/w_custom_image.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var theme;

class SignPage extends StatefulWidget {
  const SignPage({super.key});
  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final GlobalKey globalKey = GlobalKey();
  final nickNameController = Get.put(TextFieldsController());
  final imagePickerController = Get.put(ImagePickerController());
  final telNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
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
                onPressed: () {
                  Navigator.of(context).pop();
                  HapticFeedback.lightImpact();
                  nickNameController.controller.text = "";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            const Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            _buildProfileImage(),
            const SizedBox(height: 16),
            _buildNickNameField(),
            _buildTelNumberField(),
            const SizedBox(height: 16),
            _buildRegisterButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(1),
        height: 112,
        width: 112,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(56),
          color: theme.hintColor.withOpacity(0.2),
        ),
        child: Button(
          color: theme.hintColor,
          onPressed: () async {
            HapticFeedback.lightImpact();
            if (imagePickerController.isImageSelected == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogWidget(
                    title: "프로필 사진",
                    content: "프로필 사진 지우시겠습니까?",
                    onPressed: () {
                      Navigator.of(context).pop();
                      HapticFeedback.lightImpact();
                      imagePickerController.imageEmpty();
                    },
                  );
                },
              );
            } else {
              await imagePickerController.selectImage();
            }
          },
          child: ClipOval(
            child: RepaintBoundary(
              key: globalKey,
              child: FutureBuilder<bool>(
                future: imagePickerController.isImageExists,
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
                          File(imagePickerController.selectedImage.path),
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Obx(() {
                          return CustomProfile(nickName: nickNameController.getText);
                        });
                      }
                    }
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNickNameField() {
    return RoundWidget(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      borderRadius: BorderRadius.circular(18),
      color: theme.hintColor.withOpacity(0.1),
      child: Obx(() {
        nickNameController.getText;
        return TextField(
          controller: nickNameController.controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "닉네임",
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }),
    );
  }

  Widget _buildTelNumberField() {
    return RoundWidget(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      borderRadius: BorderRadius.circular(18),
      color: theme.hintColor.withOpacity(0.1),
      child: TextField(
        controller: telNumberController,
        inputFormatters: [PhoneNumberInputFormatter()],
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "전화번호",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 80,
      width: double.infinity,
      child: Button(
        borderRadius: 18,
        color: theme.hintColor.withOpacity(0.2),
        child: const Text("등록"),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (nickNameController.getText == "") {
            await showDialog(
              context: context,
              builder: (context) {
                return const CustomDialogWidget(
                  title: "알림",
                  content: "닉네임을 입력해주세요.",
                );
              },
            );
            return;
          }
          if (telNumberController.text == "" || telNumberController.text.length != 13) {
            await showDialog(
              context: context,
              builder: (context) {
                return const CustomDialogWidget(
                  title: "알림",
                  content: "전화번호 입력을 확인해주세요.",
                );
              },
            );
            return;
          }
          RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
          ui.Image image = await boundary.toImage();
          ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          if (byteData != null) {
            Uint8List pngBytes = byteData.buffer.asUint8List();
            await prefs.setString("nickName", nickNameController.getText);
            await prefs.setString("tel", telNumberController.text.replaceAll("-", ""));
            await prefs.setString("profile", base64Encode(pngBytes));
            if (await insertUserPreferences() == "failed") {
              await showDialog(
                context: context,
                builder: (context) {
                  return const CustomDialogWidget(
                    title: "알림",
                    content: "로그인이 완료되었습니다.",
                  );
                },
              );
            } else {
              await showDialog(
                context: context,
                builder: (context) {
                  return const CustomDialogWidget(
                    title: "알림",
                    content: "등록되지 않은 회원입니다.\n자동으로 등록합니다.",
                  );
                },
              );
            }
            nickNameController.controller.text = "";
            Navigator.of(context).pop();
            HapticFeedback.lightImpact();
          }
        },
      ),
    );
  }
}
