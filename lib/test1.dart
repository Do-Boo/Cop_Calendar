import 'package:events_app/api/api_data.dart';
import 'package:events_app/api/api_kakao_login.dart';
import 'package:events_app/api/v_model.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
    javaScriptAppKey: kakaoJavaScriptAppKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final viewModel = ViewModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kakao Login Example'),
        ),
        body: Center(
          child: Column(
            children: [
              // Image.network(viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? ""),
              // Text(viewModel.user?.kakaoAccount?.profile?.nickname ?? ""),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.login();
                  setState(() {});
                },
                child: const Text('Kakao Login'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.logout();
                  setState(() {});
                },
                child: const Text('Kakao LogOut'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
