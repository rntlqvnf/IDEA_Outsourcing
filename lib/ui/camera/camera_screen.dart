import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/store/gallery/gallery_store.dart';
import 'package:python_app/ui/theme.dart';
import 'package:simple_animations/simple_animations.dart';

enum TAB { GALLERY, CAMERA }

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, AnimationMixin {
  CameraStore cameraStore;
  GalleryStore galleryStore;
  Animation<double> toggleAnimation;
  TabController _tabController;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _promptPermissionSetting().then((granted) {
      if (granted) {
        cameraStore = context.read<CameraStore>();
        galleryStore = context.read<GalleryStore>();
        galleryStore.initAlbums();
      } else {
        Navigator.pop(context);
      }
    });
  }

  void _initAnimations() {
    toggleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    _tabController = TabController(
        length: TAB.values.length, vsync: this, initialIndex: currentIndex);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.camera.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid &&
            await Permission.storage.request().isGranted &&
            await Permission.camera.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: TAB.values[currentIndex] == TAB.CAMERA
              ? Text(
                  '사진',
                  style: BaseTheme.appBarTextStyle.copyWith(
                      fontSize: ScreenUtil()
                          .setSp(BaseTheme.appBarTextStyle.fontSize)),
                )
              : DropdownButton<Album>(
                  items: galleryStore.albums.map((Album album) {
                    return new DropdownMenuItem<Album>(
                      value: album,
                      child: new Text(album.name,
                          style: BaseTheme.appBarTextStyle.copyWith(
                              fontSize: ScreenUtil()
                                  .setSp(BaseTheme.appBarTextStyle.fontSize))),
                    );
                  }).toList(),
                  onChanged: (album) {
                    //galleryStore.changeAlbum(album);
                  },
                )),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        labelStyle: BaseTheme.bottomBarTextStyle,
        unselectedLabelColor: BaseTheme.deactivatedText,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 1,
        indicatorColor: BaseTheme.black,
        isScrollable: false,
        tabs: <Widget>[
          Tab(
            text: "갤러리",
          ),
          Tab(
            text: "촬영",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(controller: _tabController, children: <Widget>[
            Container(),
            _cameraPreviewScreen(),
          ]),
          TabBarView(
            controller: _tabController,
            children: <Widget>[_takePictureScreen(), _takePictureScreen()],
          )
        ],
      ),
    );
  }

  Widget _cameraPreviewScreen() {
    return Observer(builder: (_) {
      return cameraStore.loading
          ? Container(
              decoration: BoxDecoration(color: Colors.black),
            )
          : AspectRatio(
              aspectRatio: cameraStore.aspectRatio,
              child: CameraPreview(cameraStore.controller),
            );
    });
  }

  Widget _takePictureScreen() {
    return Column(
      children: <Widget>[
        SizedBox(
            height: ScreenUtil().setHeight(1200),
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
            child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
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
    );
  }

  Widget _galleryScreen() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(1200),
            child: Image.file(File(cameraStore.filePath)),
          ),
          Expanded(
            child: Container(
              child: Text('테스트'),
            ),
          )
        ],
      ),
    );
  }
}
