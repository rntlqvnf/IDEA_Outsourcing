// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStore, Store {
  final _$loadingAtom = Atom(name: '_GalleryStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$mediumsAtom = Atom(name: '_GalleryStore.mediums');

  @override
  List<Medium> get mediums {
    _$mediumsAtom.reportRead();
    return super.mediums;
  }

  @override
  set mediums(List<Medium> value) {
    _$mediumsAtom.reportWrite(value, super.mediums, () {
      super.mediums = value;
    });
  }

  final _$albumsAtom = Atom(name: '_GalleryStore.albums');

  @override
  List<Album> get albums {
    _$albumsAtom.reportRead();
    return super.albums;
  }

  @override
  set albums(List<Album> value) {
    _$albumsAtom.reportWrite(value, super.albums, () {
      super.albums = value;
    });
  }

  final _$currentAlbumAtom = Atom(name: '_GalleryStore.currentAlbum');

  @override
  Album get currentAlbum {
    _$currentAlbumAtom.reportRead();
    return super.currentAlbum;
  }

  @override
  set currentAlbum(Album value) {
    _$currentAlbumAtom.reportWrite(value, super.currentAlbum, () {
      super.currentAlbum = value;
    });
  }

  final _$reloadMediumsAsyncAction = AsyncAction('_GalleryStore.reloadMediums');

  @override
  Future<void> reloadMediums() {
    return _$reloadMediumsAsyncAction.run(() => super.reloadMediums());
  }

  final _$_GalleryStoreActionController =
      ActionController(name: '_GalleryStore');

  @override
  void initAlbums() {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
        name: '_GalleryStore.initAlbums');
    try {
      return super.initAlbums();
    } finally {
      _$_GalleryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
        name: '_GalleryStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_GalleryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
mediums: ${mediums},
albums: ${albums},
currentAlbum: ${currentAlbum}
    ''';
  }
}
