import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastGenerator {
  static void errorToast(BuildContext context, String desc) {
    if (desc != null && desc.isNotEmpty) {
      showToast(
        desc,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: Color(0xFFF45C43).withOpacity(0.8),
        textStyle: TextStyle(
          fontSize: ScreenUtil().setSp(45),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
      );
    }
  }

  static void successToast(BuildContext context, String desc) {
    if (desc != null && desc.isNotEmpty) {
      showToast(
        desc,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: Colors.green.withOpacity(0.8),
        textStyle: TextStyle(
          fontSize: ScreenUtil().setSp(45),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: Color(0xFFFFFFFF),
        ),
      );
    }
  }

  static void infoToast(BuildContext context, String desc) {
    if (desc != null && desc.isNotEmpty) {
      showToast(
        desc,
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor:
            Color(0xFFF45C43).withOpacity(0.7), // TODO : fix color fit
        textStyle: TextStyle(
          fontSize: ScreenUtil().setSp(45),
          fontFamily: 'Poppins',
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}
