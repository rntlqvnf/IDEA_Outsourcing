import 'package:mobx/mobx.dart';
import 'package:photo_manager/photo_manager.dart';

import '../base_store.dart';
import 'gallery_store_intf.dart';

part 'gallery_store.g.dart';

class GalleryStore = _GalleryStore with _$GalleryStore;

abstract class _GalleryStore
    with BaseStore, Store
    implements GalleryStoreInterface {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  static const _loadCount = 50;

  @observable
  List<AssetPathEntity> galleries = [];

  @observable
  AssetPathEntity currentGallery;

  @observable
  Map<AssetPathEntity, GalleryData> _galleryMap = {};

  @observable
  GalleryData currentGalleryData;

  @observable
  ThumbFormat format = ThumbFormat.jpeg;

  @observable
  bool _loadingGalleries = true;

  @observable
  bool _loadingImages = true;

  @computed
  get loading => _loadingGalleries || _loadingImages;

  @computed
  get totalImageCount => currentGallery.assetCount;

  @computed
  get longestGalleryName => _findLongtestGalleryName();

  // actions:-------------------------------------------------------------------
  @override
  @action
  Future<void> initGallery() async {
    _loadingGalleries = true;
    _loadingImages = true;
    await refreshGalleryList();
    await changeGallery(galleries[0]);
    changeImage(currentGalleryData.images[0]);
  }

  @override
  @action
  Future<void> changeGallery(AssetPathEntity gallery) async {
    currentGallery = gallery;
    await refreshImages();
  }

  @override
  @action
  void changeImage(AssetEntity image) {
    currentGalleryData.currentImage = image;
  }

  @override
  @action
  Future<void> refreshGalleryList() async {
    _loadingGalleries = true;

    final option = _makeOption();

    _reset();
    var list = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
      onlyAll: false,
      filterOption: option,
    );

    list.sort((s1, s2) {
      return s2.assetCount.compareTo(s1.assetCount);
    });

    galleries.addAll(list);

    _loadingGalleries = false;
  }

  @override
  @action
  Future<void> refreshImages() async {
    _loadingImages = true;

    await currentGallery.refreshPathProperties();
    final list = await currentGallery.getAssetListPaged(0, _loadCount);

    currentGalleryData = _getOrCreateGalleryData(currentGallery);
    currentGalleryData
      ..page = 0
      ..images.clear()
      ..images.addAll(list)
      ..isInit = true;

    _loadingImages = false;
  }

  @override
  @action
  Future<void> loadMoreImages() async {
    _loadingImages = true;

    if (currentGalleryData.images.length < totalImageCount) {
      final list = await currentGallery.getAssetListPaged(
          currentGalleryData.page + 1, _loadCount);

      currentGalleryData
        ..page += 1
        ..images.addAll(list);
    }

    _loadingImages = false;
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
  FilterOptionGroup _makeOption() {
    SizeConstraint sizeConstraint = SizeConstraint(
      minWidth: 0,
      maxWidth: 10000,
      minHeight: 0,
      maxHeight: 10000,
      ignoreSize: false,
    );

    final option = FilterOption(
      sizeConstraint: sizeConstraint,
    );

    return FilterOptionGroup()..setOption(AssetType.image, option);
  }

  void _reset() {
    galleries.clear();
    _galleryMap.clear();
  }

  String _findLongtestGalleryName() {
    if (_loadingGalleries) return '';
    String longestGalleryName = '갤러리';
    for (int i = 1; i < galleries.length; i++) {
      var gallery = galleries[i];
      if (gallery.name.length > longestGalleryName.length)
        longestGalleryName = gallery.name;
    }
    return longestGalleryName;
  }

  GalleryData _getOrCreateGalleryData(AssetPathEntity pathEntity) {
    _galleryMap[pathEntity] ??= GalleryData();
    return _galleryMap[pathEntity];
  }
}

class GalleryData {
  List<AssetEntity> images = [];
  AssetEntity currentImage;
  int page = 0;
  bool isInit = false;
}
