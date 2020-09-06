import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:python_app/contants/globals.dart';
import 'package:python_app/service/camera_service.dart';
import 'package:python_app/store/base_store.dart';

part 'gallery_store.g.dart';

class GalleryStore = _GalleryStore with _$GalleryStore;

abstract class _GalleryStore extends BaseStore with Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------

  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  @observable
  bool loading = false;

  @observable
  List<Medium> mediums;

  @observable
  List<Album> albums;

  // actions:-------------------------------------------------------------------
  @action
  void initAlbums() {
    loading = true;
    PhotoGallery.listAlbums(mediumType: MediumType.image)
        .then((albums) => this.albums = albums)
        .catchError((e) => error('앨범을 가져오는데 실패했습니다.'))
        .whenComplete(() => loading = false);
  }

  @action
  Future<void> changeAlbum(Album album) async {
    mediums = (await album.listMedia()).items;
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
