import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  final dynamic nickName;

  const CustomProfile({super.key, this.nickName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 112,
      width: 112,
      color: Colors.white,
      child: AutoSizeText(
        nickName ?? "닉네임",
        maxLines: 1,
        style: const TextStyle(fontSize: 178, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
