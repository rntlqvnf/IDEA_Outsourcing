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

class EmotionProvider extends ChangeNotifier {
  String emotion = 'Angry';

  void setEmotion(String newEmotion) {
    emotion = newEmotion;
    notifyListeners();
  }
}

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
                direction: TextDirection.ltr,
                tabTextStyle: BaseTheme.bottomBarTextStyle,
                selectedTabTextStyle: BaseTheme.bottomBarTextStyle,
                onSelect: (tabIndex) async {
                  switch (tabIndex) {
                    case 1:
                      AppAvailability.launchApp("com.jiangdg.usbcamera");
                      break;
                    case 3:
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
                                        indicatorType:
                                            Indicator.lineSpinFadeLoader,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('분석중...',
                                        style: BaseTheme.widgetTextStyle)
                                  ],
                                ),
                              ),
                            );
                          },
                          clickClose: false,
                          allowClick: false,
                          duration: Duration(seconds: 1));

                      SocketService service = locator<SocketService>();
                      var galleryStore =
                          Provider.of<GalleryStore>(context, listen: false);
                      var data = await galleryStore
                          .currentGalleryData.titleImage.originBytes;
                      await locator<SocketService>()
                          .setConnection('211.57.9.212', 9000);
                      service.sendImage(data, (result) {
                        print(utf8.decode(result));
                        Provider.of<EmotionProvider>(context, listen: false)
                            .setEmotion(utf8.decode(result));
                      });
                      break;
                    default:
                  }
                },
                tabs: <Tab>[
                  Tab(text: '갤러리', icon: Icon(Icons.photo)),
                  Tab(text: '카메라', icon: Icon(Icons.camera)),
                  Tab(text: '편집', icon: Icon(Icons.edit)),
                  Tab(text: '다음', icon: Icon(Icons.arrow_forward_ios)),
                ],
                contents: <Widget>[
                  Builder(
                    builder: Routes.routes[Routes.gallery],
                  ),
                  Builder(
                    builder: Routes.routes[Routes.gallery],
                  ),
                  Builder(
                    builder: Routes.routes[Routes.gallery],
                  ),
                  Builder(
                    builder: Routes.routes[Routes.home],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
