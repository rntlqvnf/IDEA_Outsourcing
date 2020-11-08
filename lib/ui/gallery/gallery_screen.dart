import 'dart:io';

import 'package:emusic/ui/gallery/grid_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../store/gallery/gallery_store.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  GalleryStore galleryStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    galleryStore.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: _galleryGridView()),
          Expanded(child: _selectedImageScreen())
        ],
      ),
    );
  }

  Widget _galleryGridView() {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Observer(builder: (_) {
              var galleryData = galleryStore.currentGalleryData;
              return CustomScrollView(
                slivers: [
                  SliverGrid(
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
                                      onTap: () =>
                                          galleryData.changeImage(image),
                                      child: Observer(builder: (_) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: galleryData.titleImage ==
                                                      image
                                                  ? Colors.white
                                                      .withOpacity(0.4)
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
                      ))
                ],
              );
            });
          },
        ));
  }

  Widget _selectedImageScreen() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Observer(builder: (_) {
        return !galleryStore.isInit
            ? Container()
            : Observer(builder: (_) {
                return StreamBuilder(
                  initialData: kTransparentImage,
                  stream: Stream.fromFuture(
                      galleryStore.currentGalleryData.titleImage.originBytes),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return ErrorWidget(snapshot.error);
                    } else {
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
      }),
    );
  }
}
