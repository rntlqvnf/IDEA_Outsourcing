// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStore, Store {
  Computed<String> _$longestGalleryNameComputed;

  @override
  String get longestGalleryName => (_$longestGalleryNameComputed ??=
          Computed<String>(() => super.longestGalleryName,
              name: '_GalleryStore.longestGalleryName'))
      .value;
  Computed<GalleryDataStore> _$currentGalleryDataComputed;

  @override
  GalleryDataStore get currentGalleryData => (_$currentGalleryDataComputed ??=
          Computed<GalleryDataStore>(() => super.currentGalleryData,
              name: '_GalleryStore.currentGalleryData'))
      .value;
  Computed<bool> _$isInitComputed;

  @override
  bool get isInit => (_$isInitComputed ??=
          Computed<bool>(() => super.isInit, name: '_GalleryStore.isInit'))
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
  Map<AssetPathEntity, GalleryDataStore> get _galleryMap {
    _$_galleryMapAtom.reportRead();
    return super._galleryMap;
  }

  @override
  set _galleryMap(Map<AssetPathEntity, GalleryDataStore> value) {
    _$_galleryMapAtom.reportWrite(value, super._galleryMap, () {
      super._galleryMap = value;
    });
  }

  final _$_isInitGalleryAtom = Atom(name: '_GalleryStore._isInitGallery');

  @override
  bool get _isInitGallery {
    _$_isInitGalleryAtom.reportRead();
    return super._isInitGallery;
  }

  @override
  set _isInitGallery(bool value) {
    _$_isInitGalleryAtom.reportWrite(value, super._isInitGallery, () {
      super._isInitGallery = value;
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

  @override
  String toString() {
    return '''
galleries: ${galleries},
currentGallery: ${currentGallery},
longestGalleryName: ${longestGalleryName},
currentGalleryData: ${currentGalleryData},
isInit: ${isInit}
    ''';
  }
}
