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

  // actions:-------------------------------------------------------------------
  @action
  void initAlbums() {
    loading = true;
    PhotoGallery.listAlbums(mediumType: MediumType.image).then((albums) {
      this.albums = albums;
      this.currentAlbum = albums[0];
      reloadMediums()
          .then((_) => loading = false)
          .catchError((e) => error('사진들을 가져오는데 실패했습니다.'));
    }).catchError((e) => error('앨범을 가져오는데 실패했습니다.'));
  }

  @action
  Future<void> reloadMediums() async {
    mediums = (await currentAlbum.listMedia()).items;
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
