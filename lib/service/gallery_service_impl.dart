import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:python_app/service/gallery_service.dart';

class GalleryServiceImpl implements GalleryService {
  List<Album> _albums;

  GalleryServiceImpl() {
    initAlbums();
  }

  @override
  List<Album> get albums => _albums;

  @override
  Future<List<Medium>> getMediums(Album album) async {
    return (await album.listMedia()).items;
  }

  @override
  Future<void> initAlbums() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      _albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
    }
  }

  @override
  Future<void> precacheImages(
      List<Medium> mediums, BuildContext context) async {
    mediums.forEach((m) {
      precacheImage(PhotoProvider(mediumId: m.id), context);
    });
  }

  @override
  bool isInitialized() {
    return _albums != null;
  }
}
