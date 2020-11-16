import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:emusic/contants/globals.dart';
import 'package:emusic/routes.dart';
import 'package:emusic/service/socket_service.dart';
import 'package:emusic/store/gallery/gallery_store.dart';
import 'package:emusic/ui/main_menu/vertical_tab.dart';
import 'package:emusic/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: VerticalTabs(
                tabsWidth: ScreenUtil().setWidth(150),
                tabTextStyle: BaseTheme.bottomBarTextStyle
                    .copyWith(fontSize: ScreenUtil().setSp(14)),
                selectedTabTextStyle: BaseTheme.bottomBarTextStyle
                    .copyWith(fontSize: ScreenUtil().setSp(14)),
                onSelect: (tabIndex) {
                  switch (tabIndex) {
                    case 1:
                      AppAvailability.launchApp("com.jiangdg.usbcamera")
                          .catchError(BotToast.showCustomText(
                        toastBuilder: (cancelFunc) {
                          return Text('카메라를 여는데 실패했습니다');
                        },
                      ));
                      break;
                    default:
                  }
                },
                tabs: <Tab>[
                  Tab(
                      text: '갤러리',
                      icon: Icon(
                        Icons.photo,
                        size: 50,
                      )),
                  Tab(
                      text: '카메라',
                      icon: Icon(
                        Icons.camera,
                        size: 50,
                      )),
                  Tab(
                      text: '편집',
                      icon: Icon(
                        Icons.edit,
                        size: 50,
                      )),
                ],
                contents: <Widget>[
                  Builder(
                    builder: Routes.routes[Routes.gallery],
                  ),
                  Builder(
                    builder: Routes.routes[Routes.gallery],
                  ),
                  Builder(
                    builder: Routes.routes[Routes.editing],
                  ),
                ],
                nextButton: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 50,
                    ),
                    onPressed: () {
                      _showLoadingOnSendingImage();
                      _sendImageAndReceiveResult(context).then((result) =>
                          Navigator.pushNamed(context, Routes.home,
                              arguments: result));
                    }),
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _showLoadingOnSendingImage() {
    BotToast.showCustomLoading(
        toastBuilder: (cancelFunc) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 25,
                    child: LoadingIndicator(
                      color: Colors.grey,
                      indicatorType: Indicator.lineSpinFadeLoader,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('분석중...', style: BaseTheme.widgetTextStyle)
                ],
              ),
            ),
          );
        },
        clickClose: false,
        allowClick: false,
        duration: Duration(seconds: 1));
  }

  Future<String> _sendImageAndReceiveResult(BuildContext context) async {
    SocketService service = locator<SocketService>();
    var galleryStore = Provider.of<GalleryStore>(context, listen: false);
    var data = await galleryStore.currentGalleryData.titleImage.originBytes;
    Future.delayed(Duration(seconds: 2));
    return 'Angry';
    /*
    await locator<SocketService>().setConnection('211.57.9.212', 9000);
    service.sendImage(data, (result) {});
    */
  }
}
