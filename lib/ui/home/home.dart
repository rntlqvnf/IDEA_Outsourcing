import 'package:emusic/ui/main_menu/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emusic/routes.dart';
import 'package:emusic/ui/home/widgets/horizontal_place_item.dart';
import 'package:emusic/ui/home/widgets/search_bar.dart';
import 'package:emusic/ui/home/widgets/vertical_place_item.dart';
import 'package:emusic/ui/util/places.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TyperAnimatedTextKit(
                      speed: Duration(milliseconds: 100),
                      isRepeatingAnimation: false,
                      text: [
                        '사용자님의 현재 감정은 ${ModalRoute.of(context).settings.arguments} 입니다'
                      ],
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: SearchBar(),
              ),
              buildVerticalList(),
            ],
          ),
        ),
        Expanded(child: buildHorizontalList(context)),
      ],
    ));
  }

  Widget buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0.0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
