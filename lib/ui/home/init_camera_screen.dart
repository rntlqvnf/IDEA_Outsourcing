import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class InitCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1440, height: 2560, allowFontScaling: true);

    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TyperAnimatedTextKit(
                    speed: Duration(milliseconds: 80),
                    isRepeatingAnimation: false,
                    text: ['지금 당신에게 맞는 노래를 추천받아보세요!'],
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(60),
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            )
          ],
        ),
        Align(
            alignment: FractionalOffset.bottomCenter, child: Icon(Icons.camera))
      ],
    )));
  }
}
