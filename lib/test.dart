import 'package:events_app/function/f_url_href.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Link Text Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Link Text Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Click here to visit ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'https://www.example.com',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchURL('https://www.example.com');
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Linkify(
                text: 'Click here to visit https://www.example.com',
                style: const TextStyle(color: Colors.black),
                linkStyle: const TextStyle(color: Colors.blue),
                onOpen: (link) async {
                  if (await canLaunchUrl(Uri.parse(link.url))) {
                    await launchUrl(Uri.parse(link.url));
                  } else {
                    throw 'Could not launch ${link.url}';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
