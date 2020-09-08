import 'package:mobx/mobx.dart';
import 'package:photo_manager/photo_manager.dart';

import '../base_store.dart';
import 'gallery_store.dart';

part 'gallery_store_impl.g.dart';

class GalleryStoreImpl = _GalleryStoreImpl with _$GalleryStoreImpl;

abstract class _GalleryStoreImpl with BaseStore, Store implements GalleryStore {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  static const _loadCount = 50;

  @observable
  List<AssetPathEntity> _galleries = [];

  @observable
  AssetPathEntity _currentGallery;

  @observable
  Map<AssetPathEntity, GalleryData> _galleryMap = {};

  @observable
  bool _loadingGalleries = true;

  @observable
  bool _loadingImages = true;

  @override
  @computed
  get galleries => _galleries;

  @override
  @computed
  get currentGallery => _currentGallery;

  @override
  @computed
  get images => _galleryMap[_currentGallery]?.images;

  @override
  @computed
  get currentImage => _galleryMap[_currentGallery]?.currentImage;

  @override
  @computed
  get totalImageCount => _currentGallery.assetCount;

  @override
  @computed
  get loading => _loadingGalleries || _loadingImages;

  @override
  @computed
  get longestGalleryName => _findLongtestGalleryName();

  @override
  @computed
  get format => ThumbFormat.jpeg;

  // actions:-------------------------------------------------------------------
  @override
  @action
  Future<void> initGallery() async {
    _loadingGalleries = true;
    _loadingImages = true;
    await refreshGalleryList();
    await changeGallery(_galleries[0]);
    changeImage(images[0]);
  }

  @override
  @action
  Future<void> changeGallery(AssetPathEntity gallery) async {
    _currentGallery = gallery;
    await refreshImages();
  }

  @override
  @action
  void changeImage(AssetEntity image) {
    _galleryMap[_currentGallery].currentImage = image;
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

    _galleries.addAll(list);

    _loadingGalleries = false;
  }

  @override
  @action
  Future<void> refreshImages() async {
    _loadingImages = true;

    await _currentGallery.refreshPathProperties();
    final list = await _currentGallery.getAssetListPaged(0, _loadCount);

    _getOrCreateGalleryData(_currentGallery)
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

    var galleryData = _getOrCreateGalleryData(_currentGallery);

    if (galleryData.images.length < totalImageCount) {
      final list = await _currentGallery.getAssetListPaged(
          galleryData.page + 1, _loadCount);

      galleryData
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
    _galleries.clear();
    _galleryMap.clear();
  }

  String _findLongtestGalleryName() {
    if (_loadingGalleries) return '';
    String longestGalleryName = '갤러리';
    for (int i = 1; i < _galleries.length; i++) {
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
