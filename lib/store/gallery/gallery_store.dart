import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:python_app/service/navigation_service.dart';

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
  _GalleryStore() {
    albums = locator<GalleryService>().albums;
    changeAlbum(albums[0]);
  }

  // services:------------------------------------------------------------------
  GalleryService galleryService = locator<GalleryService>();

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  @observable
  List<Medium> mediums;

  @observable
  List<Album> albums;

  @observable
  Album currentAlbum;

  @observable
  Medium currentMedium;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> changeAlbum(Album album) async {
    currentAlbum = album;
    mediums = await galleryService.getMediums(currentAlbum);
    galleryService.precacheImages(
        mediums, locator<NavigationService>().key.currentState.context);
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
