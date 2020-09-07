import 'package:flutter/cupertino.dart';
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
    _albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
  }

  @override
  Future<void> precacheImages(BuildContext context) async {
    var mediums = await _albums[0].listMedia();
    mediums.items.forEach((m) {
      precacheImage(PhotoProvider(mediumId: m.id), context);
    });
  }

  @override
  bool isInitialized() {
    return _albums != null;
  }
}
