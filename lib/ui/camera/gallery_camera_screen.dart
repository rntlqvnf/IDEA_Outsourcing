import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
// import 'package:camera/camera.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:menu_button/menu_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../routes.dart';
import '../../store/gallery/gallery_store.dart';
import '../theme.dart';
import 'grid_image.dart';

enum TAB { GALLERY, CAMERA }

class GalleryCameraScreen extends StatefulWidget {
  @override
  _GalleryCameraScreenState createState() => _GalleryCameraScreenState();
}

class _GalleryCameraScreenState extends State<GalleryCameraScreen>
    with WidgetsBindingObserver, AnimationMixin {
  // CameraStore cameraStore;
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
    // cameraStore = context.read<CameraStore>();
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
    // cameraStore.dispose();
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
                            onTap: () {
                              galleryStore
                                  .currentGalleryData.titleImage.originBytes
                                  .then((bytes) => Navigator.of(context)
                                      .pushNamed(Routes.image,
                                          arguments: bytes));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 20, right: 20),
                              child: Text('다음',
                                  style: BaseTheme.appBarTextStyle
                                      .copyWith(color: BaseTheme.darkBlue)),
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
                    return !galleryStore.isInit
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
                            galleryStore.currentGallery.name == 'Recent'
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
    return Container(
      decoration: BoxDecoration(color: Colors.black),
    );
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
                                // cameraStore.toggleCamera();
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
          padding: EdgeInsets.only(top: 3, bottom: 1.5),
          sliver: SliverAppBar(
              leading: Container(),
              expandedHeight: ScreenUtil().setHeight(1200),
              floating: false,
              pinned: true,
              flexibleSpace: Observer(builder: (_) {
                return !galleryStore.isInit
                    ? Container()
                    : Observer(builder: (_) {
                        return StreamBuilder(
                          initialData: kTransparentImage,
                          stream: Stream.fromFuture(galleryStore
                              .currentGalleryData.titleImage.originBytes),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return ErrorWidget(snapshot.error);
                            } else {
                              //TODO : Java.lang.UnsuppotedOperaionException
                              // Caller must hold ACCESS_MEDIA_LOCATION permission to access
                              return ExtendedImage.memory(
                                snapshot.data,
                                fit: BoxFit.cover,
                                mode: ExtendedImageMode.gesture,
                                initGestureConfigHandler: (state) {
                                  return GestureConfig(
                                    minScale: 0.2,
                                    animationMinScale: 0.1,
                                    maxScale: 3.0,
                                    animationMaxScale: 3.5,
                                    speed: 1.0,
                                    inertialSpeed: 100.0,
                                    initialScale: 1.0,
                                    inPageView: false,
                                    initialAlignment: InitialAlignment.center,
                                  );
                                },
                              );
                            }
                          },
                        );
                      });
              })),
        ),
        StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Observer(builder: (_) {
              var galleryData = galleryStore.currentGalleryData;
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 1.5,
                    crossAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == galleryData.images.length) {
                        galleryData
                            .loadMoreImages()
                            .then((_) => setState(() {}));
                        return Container();
                      } else if (index > galleryData.images.length) {
                        return Container();
                      }
                      var image = galleryData.images[index];

                      return Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: GridImage(
                                  key: ValueKey(image),
                                  image: image,
                                  format: galleryData.format,
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => galleryData.changeImage(image),
                                  child: Observer(builder: (_) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: galleryData.titleImage == image
                                              ? Colors.white.withOpacity(0.4)
                                              : Colors.transparent),
                                    );
                                  }),
                                ),
                              )
                            ],
                          ));
                    },
                    childCount:
                        !galleryStore.isInit ? 0 : galleryData.assetCount,
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    addSemanticIndexes: true,
                  ));
            });
          },
        )
      ],
    ));
  }
}
