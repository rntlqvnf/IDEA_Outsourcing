import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

import 'gallery_service.dart';

class GalleryServiceImpl implements GalleryService {
  @override
  Future<List<Medium>> getMediums(Album album) async {
    return (await album.listMedia()).items;
  }

  @override
  Future<List<Album>> getAlbums() async {
    return await PhotoGallery.listAlbums(mediumType: MediumType.image);
  }

  @override
  Future<void> precacheImages(
      List<Medium> mediums, BuildContext context) async {
    mediums.forEach((m) {
      precacheImage(PhotoProvider(mediumId: m.id), context);
    });
  }
}
