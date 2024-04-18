import 'dart:math';

import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';

class VehicleLinesDrawer {
  static Paint linePaint = Paint()
    ..color = ColorConstants.surfaceWhite
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  final List<GlobalObjectKey> buttonKeys;
  final GlobalKey imageKey;

  VehicleLinesDrawer({
    required this.buttonKeys,
    required this.imageKey,
  });

  void paint(Canvas canvas, Size size, List<IDPPoint> points) {
    final chunked = points.chunked(2);
    final chunkedButtons = buttonKeys
        .where(
          (element) => points.map((e) => e.parentID).contains(element.value),
        )
        .toList()
        .chunked(2);

    for (var i = 0; i < chunked.length; i++) {
      final points = chunked[i];
      final keys = chunkedButtons[i];

      for (var j = 0; j < points.length; j++) {
        final point = points[j];
        final key = keys[j];
        final imageBox =
            imageKey.currentContext?.findRenderObject() as RenderBox?;
        final imagePosition =
            imageBox?.globalToLocal(Offset.zero) ?? Offset.zero;
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        final position = renderBox?.localToGlobal(imagePosition);

        if (position != null) {
          final positionY = position.dy + renderBox!.size.height / 2;
          final double y = max(0, min(size.height, positionY));

          final positionX = position.dx + renderBox.size.width / 2;
          final double x = max(0, min(size.width, positionX));

          final end = Offset(x, y);
          final start = Offset(point.x * size.width, point.y * size.height);

          final middlePoint = Offset(
            end.dy == size.height || end.dy == 0
                ? end.dx
                : (start.dx + end.dx) / 2,
            end.dx == size.width || end.dx == 0
                ? end.dy
                : (start.dy + end.dy) / 2,
          );

          final path = Path()
            ..moveTo(start.dx, start.dy)
            ..quadraticBezierTo(middlePoint.dx, middlePoint.dy, end.dx, end.dy);

          canvas.drawPath(path, VehicleLinesDrawer.linePaint);
        }
      }
    }
  }
}

class VehiclePointsDrawer extends CustomPainter {
  final ovalOuterNeon = Paint()
    ..color = ColorConstants.pointColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

  final ovalOuter = Paint()
    ..color = ColorConstants.pointColor
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  final ovalInner = Paint()
    ..color = ColorConstants.pointColor
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

  final IDPImageView layout;
  final bool isFront;
  final VehicleLinesDrawer linesDrawer;

  VehiclePointsDrawer({
    required this.layout,
    required this.isFront,
    required this.linesDrawer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final points = isFront ? layout.imageFrontMarkup : layout.imageBackMarkup;

    linesDrawer.paint(canvas, size, points ?? []);
    _paintPointsOuter(size, canvas, points);
    _paintPointsInner(size, canvas, points);
    _paintPointsNeon(size, canvas, points);
  }

  void _paintPointsNeon(Size size, Canvas canvas, List<IDPPoint>? points) {
    final path = Path();
    points?.forEach((element) {
      final x = element.x * size.width;
      final y = element.y * size.height;
      path.moveTo(x, y);

      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: 7));
    });

    canvas.drawPath(path, ovalOuterNeon);
  }

  void _paintPointsInner(Size size, Canvas canvas, List<IDPPoint>? points) {
    final path = Path();
    points?.forEach((element) {
      final x = element.x * size.width;
      final y = element.y * size.height;
      path.moveTo(x, y);

      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: 3.5));
    });

    canvas.drawPath(path, ovalInner);
  }

  void _paintPointsOuter(Size size, Canvas canvas, List<IDPPoint>? points) {
    final path = Path();

    points?.forEach((element) {
      final x = element.x * size.width;
      final y = element.y * size.height;
      path.moveTo(x, y);

      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: 6.5));
    });

    canvas.drawPath(path, ovalOuter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
