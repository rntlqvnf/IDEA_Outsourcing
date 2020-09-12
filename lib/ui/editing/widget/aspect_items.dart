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
      {this.aspectRatioS, this.aspectRatio, this.isSelected = false});
  final String aspectRatioS;
  final double aspectRatio;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(ScreenUtil().setWidth(250.0), ScreenUtil().setWidth(250.0)),
      painter: AspectRatioPainter(
          aspectRatio: aspectRatio,
          aspectRatioS: aspectRatioS,
          isSelected: isSelected),
    );
  }
}

class AspectRatioPainter extends CustomPainter {
  AspectRatioPainter(
      {this.aspectRatioS, this.aspectRatio, this.isSelected = false});
  final String aspectRatioS;
  final double aspectRatio;
  final bool isSelected;
  @override
  void paint(Canvas canvas, Size size) {
    final Color color = isSelected ? Colors.black : Colors.white;
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;
    final double aspectRatioResult =
        (aspectRatio != null && aspectRatio > 0.0) ? aspectRatio : 1.0;
    canvas.drawRect(
        getDestinationRect(
            rect: const EdgeInsets.all(1.0).deflateRect(rect),
            inputSize: Size(aspectRatioResult * 100, 100.0),
            fit: BoxFit.contain),
        paint);

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: aspectRatioS,
            style: BaseTheme.bottomBarTextStyle.copyWith(color: Colors.white)),
        textDirection: TextDirection.ltr,
        maxLines: 1);
    textPainter.layout(maxWidth: rect.width);

    textPainter.paint(
        canvas,
        rect.center -
            Offset(textPainter.width / 2.0, textPainter.height / 2.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is AspectRatioPainter &&
        (oldDelegate.isSelected != isSelected ||
            oldDelegate.aspectRatioS != aspectRatioS ||
            oldDelegate.aspectRatio != aspectRatio);
  }
}
