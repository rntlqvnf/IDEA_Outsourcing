import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:python_app/ui/theme.dart';

class AspectRatioItem {
  AspectRatioItem({this.value, this.text});
  final String text;
  final double value;
}

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget(
      {this.aspectRatio, this.isSelected = false, this.drawVertexCircle});
  final double aspectRatio;
  final bool drawVertexCircle;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(ScreenUtil().setWidth(150.0), ScreenUtil().setHeight(200.0)),
      painter: AspectRatioPainter(
          aspectRatio: aspectRatio,
          drawVertexCircle: drawVertexCircle,
          isSelected: isSelected),
    );
  }
}

class AspectRatioPainter extends CustomPainter {
  AspectRatioPainter(
      {this.aspectRatio,
      this.isSelected = false,
      this.drawVertexCircle = false});
  final double aspectRatio;
  final bool drawVertexCircle;
  final bool isSelected;
  @override
  void paint(Canvas canvas, Size size) {
    final Color color =
        isSelected ? BaseTheme.lightBlue : BaseTheme.nearlyWhite;
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..color = color
      ..style = PaintingStyle.stroke;
    final double aspectRatioResult =
        (aspectRatio != null && aspectRatio > 0.0) ? aspectRatio : 1.0;

    var rectToDraw = getDestinationRect(
        rect: const EdgeInsets.all(6.0).deflateRect(rect),
        scale: 10,
        inputSize: Size(aspectRatioResult, 1),
        fit: BoxFit.contain);
    canvas.drawRect(rectToDraw, paint);

    if (drawVertexCircle) {
      paint.style = PaintingStyle.fill;
      double radius = 4;
      canvas.drawCircle(rectToDraw.bottomLeft, radius, paint);
      canvas.drawCircle(rectToDraw.bottomRight, radius, paint);
      canvas.drawCircle(rectToDraw.topLeft, radius, paint);
      canvas.drawCircle(rectToDraw.topRight, radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is AspectRatioPainter &&
        (oldDelegate.isSelected != isSelected ||
            oldDelegate.aspectRatio != aspectRatio);
  }
}
