import 'package:flutter/cupertino.dart';
import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryService {
  Future<List<Album>> getAlbums();

  Future<void> precacheImages(List<Medium> mediums, BuildContext context);

  Future<List<Medium>> getMediums(Album album);
}
