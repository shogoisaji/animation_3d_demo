import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double angleX, angleY;

  MyPainter({this.angleX = 0, this.angleY = 0});
  @override
  void paint(Canvas canvas, Size size) {
    // 3D回転を適用した座標を計算
    Offset rotatePoint(double x, double y, double z, double angleX, double angleY, Offset center) {
      // 角度をラジアンに変換
      double radX = angleX * pi / 180;
      double radY = angleY * pi / 180;

      // 軸の移動（中心を原点に）
      x -= center.dx;
      y -= center.dy;

      // Y軸周りの回転
      double newX = x * cos(radY) - z * sin(radY);
      double newZ = x * sin(radY) + z * cos(radY);

      // X軸周りの回転
      double newY = y * cos(radX) - newZ * sin(radX);

      // 元の位置に戻す
      newX += center.dx;
      newY += center.dy;

      return Offset(newX, newY);
    }

    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    var path = Path();

    var origin = Offset(125, 50);

    // 基本的な立方体の頂点を定義
    var frontTopLeft = rotatePoint(50, 50, 50, angleX, angleY, origin);
    var frontTopRight = rotatePoint(250, 50, 50, angleX, angleY, origin);
    var frontBottomLeft = rotatePoint(50, 200, 50, angleX, angleY, origin);
    var frontBottomRight = rotatePoint(250, 200, 50, angleX, angleY, origin);
    var backTopLeft = rotatePoint(50, 50, 200, angleX, angleY, origin);
    var backTopRight = rotatePoint(250, 50, 200, angleX, angleY, origin);
    var backBottomLeft = rotatePoint(50, 200, 200, angleX, angleY, origin);
    var backBottomRight = rotatePoint(250, 200, 200, angleX, angleY, origin);

    // 前面
    path
      ..moveTo(frontTopLeft.dx, frontTopLeft.dy)
      ..lineTo(frontTopRight.dx, frontTopRight.dy)
      ..lineTo(frontBottomRight.dx, frontBottomRight.dy)
      ..lineTo(frontBottomLeft.dx, frontBottomLeft.dy)
      ..close();

    // 背面
    path
      ..moveTo(backTopLeft.dx, backTopLeft.dy)
      ..lineTo(backTopRight.dx, backTopRight.dy)
      ..lineTo(backBottomRight.dx, backBottomRight.dy)
      ..lineTo(backBottomLeft.dx, backBottomLeft.dy)
      ..close();

    // 側面を描画
    path
      ..moveTo(frontTopLeft.dx, frontTopLeft.dy)
      ..lineTo(backTopLeft.dx, backTopLeft.dy)
      ..moveTo(frontTopRight.dx, frontTopRight.dy)
      ..lineTo(backTopRight.dx, backTopRight.dy)
      ..moveTo(frontBottomLeft.dx, frontBottomLeft.dy)
      ..lineTo(backBottomLeft.dx, backBottomLeft.dy)
      ..moveTo(frontBottomRight.dx, frontBottomRight.dy)
      ..lineTo(backBottomRight.dx, backBottomRight.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
