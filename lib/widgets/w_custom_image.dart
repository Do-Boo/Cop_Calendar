import 'package:events_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  final nickName;

  const CustomProfile({super.key, this.nickName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 112,
      width: 112,
      // color: color,
      child: Text(
        nickName ?? "닉네임",
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
