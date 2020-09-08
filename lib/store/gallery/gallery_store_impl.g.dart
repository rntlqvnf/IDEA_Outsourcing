// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStoreImpl on _GalleryStoreImpl, Store {
  Computed<List<AssetPathEntity>> _$galleriesComputed;

  @override
  List<AssetPathEntity> get galleries => (_$galleriesComputed ??=
          Computed<List<AssetPathEntity>>(() => super.galleries,
              name: '_GalleryStoreImpl.galleries'))
      .value;
  Computed<AssetPathEntity> _$currentGalleryComputed;

  @override
  AssetPathEntity get currentGallery => (_$currentGalleryComputed ??=
          Computed<AssetPathEntity>(() => super.currentGallery,
              name: '_GalleryStoreImpl.currentGallery'))
      .value;
  Computed<List<AssetEntity>> _$imagesComputed;

  @override
  List<AssetEntity> get images =>
      (_$imagesComputed ??= Computed<List<AssetEntity>>(() => super.images,
              name: '_GalleryStoreImpl.images'))
          .value;
  Computed<AssetEntity> _$currentImageComputed;

  @override
  AssetEntity get currentImage => (_$currentImageComputed ??=
          Computed<AssetEntity>(() => super.currentImage,
              name: '_GalleryStoreImpl.currentImage'))
      .value;
  Computed<int> _$totalImageCountComputed;

  @override
  int get totalImageCount =>
      (_$totalImageCountComputed ??= Computed<int>(() => super.totalImageCount,
              name: '_GalleryStoreImpl.totalImageCount'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_GalleryStoreImpl.loading'))
      .value;
  Computed<String> _$longestGalleryNameComputed;

  @override
  String get longestGalleryName => (_$longestGalleryNameComputed ??=
          Computed<String>(() => super.longestGalleryName,
              name: '_GalleryStoreImpl.longestGalleryName'))
      .value;
  Computed<ThumbFormat> _$formatComputed;

  @override
  ThumbFormat get format =>
      (_$formatComputed ??= Computed<ThumbFormat>(() => super.format,
              name: '_GalleryStoreImpl.format'))
          .value;

  final _$_galleriesAtom = Atom(name: '_GalleryStoreImpl._galleries');

  @override
  List<AssetPathEntity> get _galleries {
    _$_galleriesAtom.reportRead();
    return super._galleries;
  }

  @override
  set _galleries(List<AssetPathEntity> value) {
    _$_galleriesAtom.reportWrite(value, super._galleries, () {
      super._galleries = value;
    });
  }

  final _$_currentGalleryAtom = Atom(name: '_GalleryStoreImpl._currentGallery');

  @override
  AssetPathEntity get _currentGallery {
    _$_currentGalleryAtom.reportRead();
    return super._currentGallery;
  }

  @override
  set _currentGallery(AssetPathEntity value) {
    _$_currentGalleryAtom.reportWrite(value, super._currentGallery, () {
      super._currentGallery = value;
    });
  }

  final _$_galleryMapAtom = Atom(name: '_GalleryStoreImpl._galleryMap');

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

  final _$_loadingGalleriesAtom =
      Atom(name: '_GalleryStoreImpl._loadingGalleries');

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

  final _$_loadingImagesAtom = Atom(name: '_GalleryStoreImpl._loadingImages');

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

  final _$initGalleryAsyncAction = AsyncAction('_GalleryStoreImpl.initGallery');

  @override
  Future<void> initGallery() {
    return _$initGalleryAsyncAction.run(() => super.initGallery());
  }

  final _$changeGalleryAsyncAction =
      AsyncAction('_GalleryStoreImpl.changeGallery');

  @override
  Future<void> changeGallery(AssetPathEntity gallery) {
    return _$changeGalleryAsyncAction.run(() => super.changeGallery(gallery));
  }

  final _$refreshGalleryListAsyncAction =
      AsyncAction('_GalleryStoreImpl.refreshGalleryList');

  @override
  Future<void> refreshGalleryList() {
    return _$refreshGalleryListAsyncAction
        .run(() => super.refreshGalleryList());
  }

  final _$refreshImagesAsyncAction =
      AsyncAction('_GalleryStoreImpl.refreshImages');

  @override
  Future<void> refreshImages() {
    return _$refreshImagesAsyncAction.run(() => super.refreshImages());
  }

  final _$loadMoreImagesAsyncAction =
      AsyncAction('_GalleryStoreImpl.loadMoreImages');

  @override
  Future<void> loadMoreImages() {
    return _$loadMoreImagesAsyncAction.run(() => super.loadMoreImages());
  }

  final _$_GalleryStoreImplActionController =
      ActionController(name: '_GalleryStoreImpl');

  @override
  void changeImage(AssetEntity image) {
    final _$actionInfo = _$_GalleryStoreImplActionController.startAction(
        name: '_GalleryStoreImpl.changeImage');
    try {
      return super.changeImage(image);
    } finally {
      _$_GalleryStoreImplActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_GalleryStoreImplActionController.startAction(
        name: '_GalleryStoreImpl.dispose');
    try {
      return super.dispose();
    } finally {
      _$_GalleryStoreImplActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
galleries: ${galleries},
currentGallery: ${currentGallery},
images: ${images},
currentImage: ${currentImage},
totalImageCount: ${totalImageCount},
loading: ${loading},
longestGalleryName: ${longestGalleryName},
format: ${format}
    ''';
  }
}
