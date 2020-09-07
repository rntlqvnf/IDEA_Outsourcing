import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';
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
  bool loading = true;

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
  void initAlbums() {
    loading = true;
    PhotoGallery.listAlbums(mediumType: MediumType.image).then((albums) {
      this.albums = albums;
      changeAlbum(albums[0])
          .then((_) => loading = false)
          .catchError((e) => error('사진들을 가져오는데 실패했습니다.'));
    }).catchError((e) => error('앨범을 가져오는데 실패했습니다.'));
  }

  @action
  Future<void> changeAlbum(Album album) async {
    currentAlbum = album;
    await _reloadMediums(currentAlbum);
    changeMedium(mediums[0]);
  }

  @action
  Future<void> _reloadMediums(Album album) async {
    mediums = (await album.listMedia()).items;
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
