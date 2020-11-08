import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emusic/ui/home/details.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Map place;

  VerticalPlaceItem({this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: Container(
          height: 70.0,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "${place["img"]}",
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Container(
                    height: 80.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${place["name"]}",
                              style: TextStyle(
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(35),
                            ),
                            Text(
                              "${place["price"]}",
                              style: TextStyle(
                                fontFamily: 'NanumGothic',
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(15),
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              '3:23',
                              style: TextStyle(
                                fontFamily: 'NanumGothic',
                                fontSize: ScreenUtil().setSp(15),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details();
              },
            ),
          );
        },
      ),
    );
  }
}
