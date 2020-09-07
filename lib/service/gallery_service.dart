import 'package:flutter/cupertino.dart';
import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryService {
  List<Album> get albums;

  Future<void> initAlbums(BuildContext context);

  Future<List<Medium>> getMediums(Album album);
}
