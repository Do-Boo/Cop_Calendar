import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPainter extends CustomPainter {
  final String text;
  final Color backgroundColor;

  MyPainter({required this.text, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw the text
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(color: Colors.black, fontSize: 30),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

Future<Uint8List?> getBlob(String text, Color backgroundColor) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  const size = Size(200, 200); // You can change this as needed.

  final painter = MyPainter(text: text, backgroundColor: backgroundColor);
  painter.paint(canvas, size);

  final picture = recorder.endRecording();
  final img = await picture.toImage(size.width.toInt(), size.height.toInt());
  final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

  return pngBytes?.buffer.asUint8List();
}

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Uint8List?>(
        future: getBlob("", const ui.Color.fromARGB(255, 59, 177, 255)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.memory(
              snapshot.data!,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const CustomProfile());
}
