import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../contants/globals.dart';
import '../../service/gallery_service.dart';
import '../base_store.dart';

part 'gallery_store.g.dart';

class GalleryStore = _GalleryStore with _$GalleryStore;

abstract class _GalleryStore extends BaseStore with Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------
  GalleryService galleryService = locator<GalleryService>();

  // store variables:-----------------------------------------------------------
  @computed
  bool get loading => locator<GalleryService>().albums == null;

  @observable
  List<Medium> mediums;

  @computed
  List<Album> get albums => locator<GalleryService>().albums;

  @observable
  Album currentAlbum;

  @observable
  Medium currentMedium;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> changeAlbum(Album album) async {
    currentAlbum = album;
    mediums = await galleryService.getMediums(currentAlbum);
    changeMedium(mediums[0]);
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
