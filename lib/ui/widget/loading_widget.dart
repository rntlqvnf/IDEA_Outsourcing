import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 30,
            width: 30,
            child: LoadingIndicator(
                indicatorType: Indicator.lineSpinFadeLoader,
                color: Colors.grey.withOpacity(0.5))));
  }
}
