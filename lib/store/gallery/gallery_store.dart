import 'package:mobx/mobx.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery_data_store.dart';
import '../base_store.dart';
part 'gallery_store.g.dart';

class GalleryStore = _GalleryStore with _$GalleryStore;

abstract class _GalleryStore with BaseStore, Store {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  @observable
  List<AssetPathEntity> galleries = [];

  @observable
  AssetPathEntity currentGallery;

  @observable
  Map<AssetPathEntity, GalleryDataStore> _galleryMap = {};

  @observable
  bool _isInitGallery = false;

  @computed
  String get longestGalleryName => _findLongtestGalleryName();

  @computed
  GalleryDataStore get currentGalleryData =>
      _getOrCreateGalleryData(currentGallery);

  @computed
  bool get isInit => _isInitGallery && currentGalleryData.isInit;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> initGallery() async {
    await refreshGalleryList();
    await changeGallery(galleries[0]);
    _isInitGallery = true;
  }

  @action
  Future<void> changeGallery(AssetPathEntity gallery) async {
    currentGallery = gallery;
    if (!currentGalleryData.isInit) await currentGalleryData.refreshImages();
  }

  @action
  Future<void> refreshGalleryList() async {
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
    String longestGalleryName = '갤러리';
    for (int i = 1; i < galleries.length; i++) {
      var gallery = galleries[i];
      if (gallery.name.length > longestGalleryName.length)
        longestGalleryName = gallery.name;
    }
    return longestGalleryName;
  }

  GalleryDataStore _getOrCreateGalleryData(AssetPathEntity gallery) {
    _galleryMap[gallery] ??= GalleryDataStore();
    _galleryMap[gallery].gallery ??= gallery;
    return _galleryMap[gallery];
  }
}
