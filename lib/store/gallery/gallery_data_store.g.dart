// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryDataStore on _GalleryDataStore, Store {
  Computed<dynamic> _$assetCountComputed;

  @override
  dynamic get assetCount =>
      (_$assetCountComputed ??= Computed<dynamic>(() => super.assetCount,
              name: '_GalleryDataStore.assetCount'))
          .value;

  final _$galleryAtom = Atom(name: '_GalleryDataStore.gallery');

  @override
  AssetPathEntity get gallery {
    _$galleryAtom.reportRead();
    return super.gallery;
  }

  @override
  set gallery(AssetPathEntity value) {
    _$galleryAtom.reportWrite(value, super.gallery, () {
      super.gallery = value;
    });
  }

  final _$imagesAtom = Atom(name: '_GalleryDataStore.images');

  @override
  List<AssetEntity> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(List<AssetEntity> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$titleImageAtom = Atom(name: '_GalleryDataStore.titleImage');

  @override
  AssetEntity get titleImage {
    _$titleImageAtom.reportRead();
    return super.titleImage;
  }

  @override
  set titleImage(AssetEntity value) {
    _$titleImageAtom.reportWrite(value, super.titleImage, () {
      super.titleImage = value;
    });
  }

  final _$pageAtom = Atom(name: '_GalleryDataStore.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isInitAtom = Atom(name: '_GalleryDataStore.isInit');

  @override
  bool get isInit {
    _$isInitAtom.reportRead();
    return super.isInit;
  }

  @override
  set isInit(bool value) {
    _$isInitAtom.reportWrite(value, super.isInit, () {
      super.isInit = value;
    });
  }

  final _$formatAtom = Atom(name: '_GalleryDataStore.format');

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

  final _$refreshImagesAsyncAction =
      AsyncAction('_GalleryDataStore.refreshImages');

  @override
  Future<void> refreshImages() {
    return _$refreshImagesAsyncAction.run(() => super.refreshImages());
  }

  final _$loadMoreImagesAsyncAction =
      AsyncAction('_GalleryDataStore.loadMoreImages');

  @override
  Future<void> loadMoreImages() {
    return _$loadMoreImagesAsyncAction.run(() => super.loadMoreImages());
  }

  final _$_GalleryDataStoreActionController =
      ActionController(name: '_GalleryDataStore');

  @override
  void changeImage(AssetEntity image) {
    final _$actionInfo = _$_GalleryDataStoreActionController.startAction(
        name: '_GalleryDataStore.changeImage');
    try {
      return super.changeImage(image);
    } finally {
      _$_GalleryDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gallery: ${gallery},
images: ${images},
titleImage: ${titleImage},
page: ${page},
isInit: ${isInit},
format: ${format},
assetCount: ${assetCount}
    ''';
  }
}
