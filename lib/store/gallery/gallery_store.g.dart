// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStore, Store {
  Computed<dynamic> _$loadingComputed;

  @override
  dynamic get loading => (_$loadingComputed ??=
          Computed<dynamic>(() => super.loading, name: '_GalleryStore.loading'))
      .value;
  Computed<dynamic> _$totalImageCountComputed;

  @override
  dynamic get totalImageCount => (_$totalImageCountComputed ??=
          Computed<dynamic>(() => super.totalImageCount,
              name: '_GalleryStore.totalImageCount'))
      .value;
  Computed<dynamic> _$longestGalleryNameComputed;

  @override
  dynamic get longestGalleryName => (_$longestGalleryNameComputed ??=
          Computed<dynamic>(() => super.longestGalleryName,
              name: '_GalleryStore.longestGalleryName'))
      .value;

  final _$galleriesAtom = Atom(name: '_GalleryStore.galleries');

  @override
  List<AssetPathEntity> get galleries {
    _$galleriesAtom.reportRead();
    return super.galleries;
  }

  @override
  set galleries(List<AssetPathEntity> value) {
    _$galleriesAtom.reportWrite(value, super.galleries, () {
      super.galleries = value;
    });
  }

  final _$currentGalleryAtom = Atom(name: '_GalleryStore.currentGallery');

  @override
  AssetPathEntity get currentGallery {
    _$currentGalleryAtom.reportRead();
    return super.currentGallery;
  }

  @override
  set currentGallery(AssetPathEntity value) {
    _$currentGalleryAtom.reportWrite(value, super.currentGallery, () {
      super.currentGallery = value;
    });
  }

  final _$_galleryMapAtom = Atom(name: '_GalleryStore._galleryMap');

  @override
  Map<AssetPathEntity, GalleryData> get _galleryMap {
    _$_galleryMapAtom.reportRead();
    return super._galleryMap;
  }

  @override
  set _galleryMap(Map<AssetPathEntity, GalleryData> value) {
    _$_galleryMapAtom.reportWrite(value, super._galleryMap, () {
      super._galleryMap = value;
    });
  }

  final _$currentGalleryDataAtom =
      Atom(name: '_GalleryStore.currentGalleryData');

  @override
  GalleryData get currentGalleryData {
    _$currentGalleryDataAtom.reportRead();
    return super.currentGalleryData;
  }

  @override
  set currentGalleryData(GalleryData value) {
    _$currentGalleryDataAtom.reportWrite(value, super.currentGalleryData, () {
      super.currentGalleryData = value;
    });
  }

  final _$formatAtom = Atom(name: '_GalleryStore.format');

  @override
  ThumbFormat get format {
    _$formatAtom.reportRead();
    return super.format;
  }

  @override
  set format(ThumbFormat value) {
    _$formatAtom.reportWrite(value, super.format, () {
      super.format = value;
    });
  }

  final _$_loadingGalleriesAtom = Atom(name: '_GalleryStore._loadingGalleries');

  @override
  bool get _loadingGalleries {
    _$_loadingGalleriesAtom.reportRead();
    return super._loadingGalleries;
  }

  @override
  set _loadingGalleries(bool value) {
    _$_loadingGalleriesAtom.reportWrite(value, super._loadingGalleries, () {
      super._loadingGalleries = value;
    });
  }

  final _$_loadingImagesAtom = Atom(name: '_GalleryStore._loadingImages');

  @override
  bool get _loadingImages {
    _$_loadingImagesAtom.reportRead();
    return super._loadingImages;
  }

  @override
  set _loadingImages(bool value) {
    _$_loadingImagesAtom.reportWrite(value, super._loadingImages, () {
      super._loadingImages = value;
    });
  }

  final _$initGalleryAsyncAction = AsyncAction('_GalleryStore.initGallery');

  @override
  Future<void> initGallery() {
    return _$initGalleryAsyncAction.run(() => super.initGallery());
  }

  final _$changeGalleryAsyncAction = AsyncAction('_GalleryStore.changeGallery');

  @override
  Future<void> changeGallery(AssetPathEntity gallery) {
    return _$changeGalleryAsyncAction.run(() => super.changeGallery(gallery));
  }

  final _$refreshGalleryListAsyncAction =
      AsyncAction('_GalleryStore.refreshGalleryList');

  @override
  Future<void> refreshGalleryList() {
    return _$refreshGalleryListAsyncAction
        .run(() => super.refreshGalleryList());
  }

  final _$refreshImagesAsyncAction = AsyncAction('_GalleryStore.refreshImages');

  @override
  Future<void> refreshImages() {
    return _$refreshImagesAsyncAction.run(() => super.refreshImages());
  }

  final _$loadMoreImagesAsyncAction =
      AsyncAction('_GalleryStore.loadMoreImages');

  @override
  Future<void> loadMoreImages() {
    return _$loadMoreImagesAsyncAction.run(() => super.loadMoreImages());
  }

  final _$_GalleryStoreActionController =
      ActionController(name: '_GalleryStore');

  @override
  void changeImage(AssetEntity image) {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
        name: '_GalleryStore.changeImage');
    try {
      return super.changeImage(image);
    } finally {
      _$_GalleryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
galleries: ${galleries},
currentGallery: ${currentGallery},
currentGalleryData: ${currentGalleryData},
format: ${format},
loading: ${loading},
totalImageCount: ${totalImageCount},
longestGalleryName: ${longestGalleryName}
    ''';
  }
}
