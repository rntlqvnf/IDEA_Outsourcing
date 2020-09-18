import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emusic/routes.dart';
import 'package:emusic/ui/home/widgets/horizontal_place_item.dart';
import 'package:emusic/ui/home/widgets/search_bar.dart';
import 'package:emusic/ui/home/widgets/vertical_place_item.dart';
import 'package:emusic/ui/util/places.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.popUntil(
                context, (route) => route.settings.name == Routes.camera);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.camera,
            ),
            onPressed: () {
              Navigator.popUntil(
                  context, (route) => route.settings.name == Routes.camera);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TyperAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
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
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(),
          ),
          buildHorizontalList(context),
          buildVerticalList(),
        ],
      ),
    );
  }

  buildHorizontalList(BuildContext context) {
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