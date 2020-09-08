import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:menu_button/menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../store/camera/camera_store.dart';
import '../../store/gallery/gallery_store.dart';
import '../theme.dart';
import '../widget/loading_widget.dart';
import 'grid_image.dart';

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
        galleryStore.initGallery();
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraStore.dispose();
    galleryStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              if (TAB.values[currentIndex] != TAB.CAMERA)
                Material(
                    color: Colors.transparent,
                    child: Center(
                        child: InkWell(
                            onTap: () => print('tab'),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
                              child:
                                  Text('다음', style: BaseTheme.appBarTextStyle),
                            ))))
            ],
            title: TAB.values[currentIndex] == TAB.CAMERA
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '사진',
                      style: BaseTheme.appBarTextStyle,
                    ))
                : Observer(builder: (_) {
                    return galleryStore.loading
                        ? Text(
                            '갤러리',
                            style: BaseTheme.appBarTextStyle,
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
                            items: galleryStore.galleries,
                            dontShowTheSameItemSelected: false,
                            topDivider: true,
                            itemBuilder: (gallery) => _buttonItem(gallery),
                            divider: Container(
                              height: 1,
                              color: Colors.transparent,
                            ),
                            onItemSelected: (gallery) =>
                                galleryStore.changeGallery(gallery),
                            onMenuButtonToggle: (_) {},
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
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _galleryGridView(),
            Stack(
              children: <Widget>[_cameraPreviewScreen(), _takePictureScreen()],
            )
          ],
        ));
  }

  Widget _buttonItem(AssetPathEntity gallery) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SizedBox(
            height: ScreenUtil().setHeight(130),
            child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(gallery.name == 'Recent' ? '갤러리' : gallery.name,
                        style: BaseTheme.appBarTextStyle.copyWith(
                          fontWeight: FontWeight.w100,
                          color: galleryStore.currentGallery == gallery
                              ? BaseTheme.deactivatedText
                              : BaseTheme.appBarTextStyle.color,
                        ))))));
  }

  Widget _buttonChild() {
    return SizedBox(
        height: ScreenUtil().setHeight(130),
        child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return AutoSizeText(galleryStore.longestGalleryName,
                          maxLines: 1,
                          style: BaseTheme.appBarTextStyle
                              .copyWith(color: Colors.transparent));
                    }),
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
                        return AutoSizeText(
                            galleryStore.currentGallery.name == 'Current'
                                ? '갤러리'
                                : galleryStore.currentGallery.name,
                            maxLines: 1,
                            style: BaseTheme.appBarTextStyle);
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

  Widget _galleryGridView() {
    return Container(
        child: CustomScrollView(
      shrinkWrap: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          sliver: SliverAppBar(
            leading: Container(),
            expandedHeight: ScreenUtil().setHeight(1200),
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(child: Observer(builder: (_) {
                  return galleryStore.loading
                      ? LoadingWidget()
                      : FutureBuilder<Uint8List>(
                          future: galleryStore.currentImage.originBytes,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return ErrorWidget(snapshot.error);
                            } else if (snapshot.hasData) {
                              return Image.memory(snapshot.data);
                            } else {
                              return LoadingWidget();
                            }
                          },
                        );
                }))
              ],
            ),
          ),
        ),
        Observer(builder: (_) {
          return SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == galleryStore.images.length) {
                    galleryStore.loadMoreImages();
                    return LoadingWidget();
                  } else if (index > galleryStore.images.length) {
                    return LoadingWidget();
                  }
                  var image = galleryStore.images[index];

                  return Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: GridImage(
                            key: ValueKey(image),
                            image: image,
                            format: galleryStore.format,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => galleryStore.changeImage(image),
                            child: Observer(builder: (_) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: galleryStore.currentImage == image
                                        ? Colors.white.withOpacity(0.4)
                                        : Colors.transparent),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount:
                    galleryStore.loading ? 0 : galleryStore.totalImageCount,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                addSemanticIndexes: true,
              ));
        })
      ],
    ));
  }
}
