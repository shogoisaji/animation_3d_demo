import 'package:animation_3d_demo/my_painter.dart';
import 'package:flutter/material.dart';

class Animation3d extends StatefulWidget {
  const Animation3d({super.key});

  @override
  Animation3dState createState() => Animation3dState();
}

class Animation3dState extends State<Animation3d> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double angleX = 0.0;
  double angleY = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.repeat();
    // y軸回転アニメーション
    _controller.addListener(() {
      setState(() {
        angleY = _controller.value * 360;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // x軸回転
          Slider(
            min: -180.0,
            max: 180.0,
            divisions: 100,
            value: angleX,
            onChanged: (double value) {
              setState(() {
                angleX = value;
              });
            },
          ),
          // y軸回転
          Slider(
            min: 0.0,
            max: 360.0,
            divisions: 100,
            value: angleY,
            onChanged: (double value) {
              setState(() {
                angleY = value;
              });
            },
          ),
          const SizedBox(
            height: 100,
          ),
          CustomPaint(
            size: const Size(300, 300),
            painter: MyPainter(angleX: angleX, angleY: angleY),
          ),
        ],
      ),
    );
  }
}
