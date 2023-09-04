import 'package:flutter/material.dart';

import 'cutoutscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://images.pexels.com/photos/2739666/pexels-photo-2739666.jpeg?cs=srgb&dl=pexels-tom-fisk-2739666.jpg&fm=jpg',
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: CustomCutoutShapeBorder(
                      CutoutScreenArea(
                        borderColor: Colors.red,
                        borderWidth: 3.0,
                        overlayColor: Color.fromRGBO(0, 0, 0, 80),
                        borderRadius: 10.0,
                        borderLength: 40.0,
                        cutOutWidth: 150.0,
                        cutOutHeight: 150.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCutoutShapeBorder extends ShapeBorder {
  final CutoutScreenArea cutoutScreenArea;

  CustomCutoutShapeBorder(this.cutoutScreenArea);

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      cutoutScreenArea.getOuterPath(rect, textDirection: textDirection),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    cutoutScreenArea.paint(canvas, rect, textDirection: textDirection);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomCutoutShapeBorder(
      CutoutScreenArea(
        borderColor: cutoutScreenArea.borderColor,
        borderWidth: cutoutScreenArea.borderWidth,
        overlayColor: cutoutScreenArea.overlayColor,
        borderRadius: cutoutScreenArea.borderRadius,
        borderLength: cutoutScreenArea.borderLength,
        cutOutWidth: cutoutScreenArea.cutOutWidth * t,
        cutOutHeight: cutoutScreenArea.cutOutHeight * t,
      ),
    );
  }
}
