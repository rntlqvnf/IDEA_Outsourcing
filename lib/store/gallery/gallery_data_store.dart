import 'package:mobx/mobx.dart';
import 'package:photo_manager/photo_manager.dart';

part 'gallery_data_store.g.dart';

class GalleryDataStore = _GalleryDataStore with _$GalleryDataStore;

abstract class _GalleryDataStore with Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  static const _loadCount = 50;

  @observable
  AssetPathEntity gallery;

  @observable
  List<AssetEntity> images = [];

  @observable
  AssetEntity currentImage;

  @observable
  int page = 0;

  @observable
  bool isInit = false;

  @observable
  ThumbFormat format = ThumbFormat.jpeg;

  @computed
  get totalImageCount => gallery.assetCount;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> refreshImages() async {
    await gallery.refreshPathProperties();
    final list = await gallery.getAssetListPaged(0, _loadCount);

    page = 0;
    images.clear();
    images.addAll(list);
    currentImage = images[0];
    isInit = true;
  }

  @action
  Future<void> loadMoreImages() async {
    if (images.length < totalImageCount) {
      final list = await gallery.getAssetListPaged(page + 1, _loadCount);

      page += 1;
      images.addAll(list);
    }
  }

  @action
  void changeImage(AssetEntity image) {
    currentImage = image;
  }

  // dispose:-------------------------------------------------------------------

  // functions:-----------------------------------------------------------------
}
