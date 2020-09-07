import 'package:flutter/cupertino.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:python_app/service/initializable_service.dart';

abstract class GalleryService with InitializableService {
  List<Album> get albums;

  Future<void> initAlbums();

  Future<void> precacheImages(BuildContext context);

  Future<List<Medium>> getMediums(Album album);
}
