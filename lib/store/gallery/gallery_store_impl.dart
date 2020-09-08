import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:python_app/store/base_store.dart';
import 'package:python_app/store/gallery/gallery_store.dart';

import '../../contants/globals.dart';
import '../../service/gallery_service.dart';

part 'gallery_store_impl.g.dart';

class GalleryStoreImpl = _GalleryStoreImpl with _$GalleryStoreImpl;

abstract class _GalleryStoreImpl with BaseStore, Store implements GalleryStore {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------
  GalleryService galleryService = locator<GalleryService>();

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = true;

  @observable
  List<Medium> mediums;

  @observable
  Map<String, Uint8List> thumbnails = {};

  @observable
  List<Album> albums;

  @observable
  Album currentAlbum;

  @observable
  Medium currentMedium;

  // actions:-------------------------------------------------------------------
  @action
  void initAlbum() {
    loading = true;
    galleryService.getAlbums().then((value) {
      albums = value;
      changeAlbum(albums[0]);
    });
  }

  @action
  Future<void> changeAlbum(Album album) async {
    loading = true;
    currentAlbum = album;
    mediums = await galleryService.getMediums(currentAlbum);
    changeMedium(mediums[0]);
    loading = false;
  }

  @action
  void compressImages(List<Medium> _mediums) {
    loading = true;
    _mediums.forEach((m) async {
      var file = await m.getFile();
      FlutterImageCompress.compressWithFile(
        file.uri.toFilePath(),
        format: CompressFormat.jpeg,
        minHeight: m.height ~/ 8,
        minWidth: m.width ~/ 8,
        quality: 70,
      ).then((compressed) {
        thumbnails.putIfAbsent(m.id, () => compressed);
        if (thumbnails.length == mediums.length) {
          loading = false;
        }
      });
    });
  }

  @action
  void changeMedium(Medium medium) {
    currentMedium = medium;
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    super.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
}
