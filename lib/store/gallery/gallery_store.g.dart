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

  final _$thumbnailsAtom = Atom(name: '_GalleryStore.thumbnails');

  @override
  Map<String, Uint8List> get thumbnails {
    _$thumbnailsAtom.reportRead();
    return super.thumbnails;
  }

  @override
  set thumbnails(Map<String, Uint8List> value) {
    _$thumbnailsAtom.reportWrite(value, super.thumbnails, () {
      super.thumbnails = value;
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

  final _$currentMediumAtom = Atom(name: '_GalleryStore.currentMedium');

  @override
  Medium get currentMedium {
    _$currentMediumAtom.reportRead();
    return super.currentMedium;
  }

  @override
  set currentMedium(Medium value) {
    _$currentMediumAtom.reportWrite(value, super.currentMedium, () {
      super.currentMedium = value;
    });
  }

  final _$changeAlbumAsyncAction = AsyncAction('_GalleryStore.changeAlbum');

  @override
  Future<void> changeAlbum(Album album) {
    return _$changeAlbumAsyncAction.run(() => super.changeAlbum(album));
  }

  final _$_GalleryStoreActionController =
      ActionController(name: '_GalleryStore');

  @override
  void initAlbum() {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
        name: '_GalleryStore.initAlbum');
    try {
      return super.initAlbum();
    } finally {
      _$_GalleryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeMedium(Medium medium) {
    final _$actionInfo = _$_GalleryStoreActionController.startAction(
        name: '_GalleryStore.changeMedium');
    try {
      return super.changeMedium(medium);
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
thumbnails: ${thumbnails},
albums: ${albums},
currentAlbum: ${currentAlbum},
currentMedium: ${currentMedium}
    ''';
  }
}
