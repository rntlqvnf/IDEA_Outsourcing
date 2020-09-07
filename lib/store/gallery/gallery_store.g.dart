// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_GalleryStore.loading'))
      .value;
  Computed<List<Album>> _$albumsComputed;

  @override
  List<Album> get albums =>
      (_$albumsComputed ??= Computed<List<Album>>(() => super.albums,
              name: '_GalleryStore.albums'))
          .value;

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
mediums: ${mediums},
currentAlbum: ${currentAlbum},
currentMedium: ${currentMedium},
loading: ${loading},
albums: ${albums}
    ''';
  }
}
