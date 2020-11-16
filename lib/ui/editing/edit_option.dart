import 'package:emusic/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditOption extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final TextStyle textStyle;
  final Function onTap;

  const EditOption({
    Key key,
    this.icon,
    this.text,
    this.textStyle = BaseTheme.bottomBarTextStyle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null)
      return IconButton(icon: icon, onPressed: onTap);
    else
      return InkWell(
        child: Column(
          children: [
            text,
            SizedBox(
              height: 10,
            ),
            icon
          ],
        ),
        onTap: onTap,
      );
  }
}
