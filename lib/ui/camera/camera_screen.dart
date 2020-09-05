import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:provider/provider.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/ui/theme.dart';
import 'package:simple_animations/simple_animations.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, AnimationMixin {
  CameraStore cameraStore;
  Animation<double> toggleAnimation;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    toggleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cameraStore = Provider.of<CameraStore>(context);
    WidgetsBinding.instance.addObserver(this);
    cameraStore.onNewCameraSelected();

    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          '사진',
          style: BaseTheme.appBarTextStyle.copyWith(
              fontSize: ScreenUtil().setSp(BaseTheme.appBarTextStyle.fontSize)),
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontWeight: FontWeight.w700),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Color(0xff1967d2),
        unselectedLabelColor: Color(0xff5f6368),
        isScrollable: true,
        indicator: MD2Indicator(
            indicatorHeight: 3,
            indicatorColor: Color(0xff1967d2),
            indicatorSize: MD2IndicatorSize.normal),
        tabs: <Widget>[
          Tab(
            text: "갤러리",
          ),
          Tab(
            text: "촬영",
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Stack(
            children: <Widget>[_cameraPreviewScreen(), _takePictureScreen()],
          )),
        ],
      ),
    );
  }

  Widget _cameraPreviewScreen() {
    return Observer(builder: (_) {
      return cameraStore.loading
          ? Container()
          : AspectRatio(
              aspectRatio: cameraStore.controller.value.aspectRatio,
              child: CameraPreview(cameraStore.controller),
            );
    });
  }

  Widget _takePictureScreen() {
    return Positioned.fill(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 6,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
                Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(50),
                            bottom: ScreenUtil().setHeight(50)),
                        child: Transform.rotate(
                          angle: pi * toggleAnimation.value,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: IconButton(
                              icon: Icon(
                                Icons.loop,
                                size: 33,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                controller.isDismissed
                                    ? controller.play()
                                    : controller.playReverse();
                                cameraStore.toggleCamera();
                              },
                            ),
                          ),
                        )))
              ],
            )),
        Expanded(
            flex: 5,
            child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Material(
                      child: InkWell(
                        customBorder: new CircleBorder(),
                        onTap: () => cameraStore.takePicture(),
                        child: Container(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setWidth(300),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Container(
                        width: ScreenUtil().setWidth(180),
                        height: ScreenUtil().setWidth(180),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    )
                  ],
                ))))
      ],
    ));
  }

  /*
  /// Display the thumbnail of the captured image or video.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoController == null && imagePath == null
                ? Container()
                : SizedBox(
                    child: (videoController == null)
                        ? Image.file(File(imagePath))
                        : Container(
                            child: Center(
                              child: AspectRatio(
                                  aspectRatio:
                                      videoController.value.size != null
                                          ? videoController.value.aspectRatio
                                          : 1.0,
                                  child: VideoPlayer(videoController)),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink)),
                          ),
                    width: 64.0,
                    height: 64.0,
                  ),
          ],
        ),
      ),
    );
  }*/
}
