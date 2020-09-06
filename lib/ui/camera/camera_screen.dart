import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:menu_button/menu_button.dart';
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
  bool onToggle = false;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _initAnimations();
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
    cameraStore = context.read<CameraStore>();
    galleryStore = context.read<GalleryStore>();
    _promptPermissionSetting().then((granted) {
      if (granted) {
        galleryStore.initAlbums();
      } else {
        Navigator.pop(context);
      }
    });
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
              : Observer(builder: (_) {
                  return galleryStore.loading
                      ? Text(
                          '갤러리',
                          style: BaseTheme.appBarTextStyle.copyWith(
                              fontSize: ScreenUtil()
                                  .setSp(BaseTheme.appBarTextStyle.fontSize)),
                        )
                      : MenuButton(
                          child: _buttonChild(),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(3.0),
                              ),
                              color: Theme.of(context).primaryColor),
                          toggledChild: _buttonChild(),
                          items: galleryStore.albums,
                          dontShowTheSameItemSelected: false,
                          topDivider: true,
                          itemBuilder: (album) => _buttonItem(album),
                          divider: Container(
                            height: 1,
                            color: Colors.transparent,
                          ),
                          onItemSelected: (album) {
                            galleryStore.currentAlbum = album;
                            galleryStore.reloadMediums();
                          },
                          onMenuButtonToggle: (toggle) {
                            setState(() {
                              onToggle = toggle;
                            });
                          },
                        );
                })),
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

  Widget _buttonItem(Album album) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SizedBox(
            height: ScreenUtil().setHeight(130),
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(album.name,
                        style: BaseTheme.appBarTextStyle.copyWith(
                            fontWeight: FontWeight.w100,
                            color: galleryStore.currentAlbum == album
                                ? BaseTheme.deactivatedText
                                : BaseTheme.appBarTextStyle.color,
                            fontSize: ScreenUtil().setSp(
                              BaseTheme.appBarTextStyle.fontSize,
                            )))))));
  }

  Widget _buttonChild() {
    String longestAlbumName = galleryStore.albums[0].name;
    galleryStore.albums.forEach((album) {
      if (album.name.length > longestAlbumName.length)
        longestAlbumName = album.name;
    });

    return SizedBox(
        height: ScreenUtil().setHeight(130),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AutoSizeText(longestAlbumName,
                        maxLines: 1,
                        style: BaseTheme.appBarTextStyle.copyWith(
                            color: Colors.transparent,
                            fontSize: ScreenUtil()
                                .setSp(BaseTheme.appBarTextStyle.fontSize))),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(
                      builder: (_) {
                        return AutoSizeText(galleryStore.currentAlbum.name,
                            maxLines: 1,
                            style: BaseTheme.appBarTextStyle.copyWith(
                                fontSize: ScreenUtil().setSp(
                                    BaseTheme.appBarTextStyle.fontSize)));
                      },
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(30),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(70),
                      height: ScreenUtil().setWidth(70),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
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
