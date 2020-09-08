import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:python_app/contants/globals.dart';
import 'package:python_app/routes.dart';

class GreetingScreen extends StatefulWidget {
  _GreetingScreenState createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> bottomButtonAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() => setState(() {}));

    bottomButtonAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);

    Future.delayed(Duration(seconds: 2), () => animationController.forward());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: TyperAnimatedTextKit(
                  speed: Duration(milliseconds: 80),
                  isRepeatingAnimation: false,
                  text: ['나에게 맞는 노래를 추천받아보세요!'],
                  textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(70),
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.topStart,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(290),
            )
          ],
        ),
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(320)),
              child: FadeTransition(
                  opacity: bottomButtonAnimation,
                  child: Material(
                      child: InkWell(
                          customBorder: new CircleBorder(),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.camera);
                          },
                          child: Container(
                              padding: EdgeInsets.all(27),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.white,
                              ))))),
            ))
      ],
    )));
  }
}
