import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:python_app/store/base_store.dart';
import 'package:python_app/store/gallery/gallery_store.dart';

import '../../contants/globals.dart';
import '../../service/gallery_service.dart';

part 'gallery_store_impl.g.dart';

class GalleryStoreImpl = _GalleryStoreImpl with _$GalleryStoreImpl;

abstract class _GalleryStoreImpl with BaseStore, Store implements GalleryStore {
  // other stores:--------------------------------------------------------------

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> disposers = [];

  // constructor:---------------------------------------------------------------
  // services:------------------------------------------------------------------

  // store variables:-----------------------------------------------------------
  List<AssetPathEntity> _galleries;

  @override
  @computed
  get galleries => _galleries;

  AssetPathEntity _currentGallery;

  @override
  @computed
  get currentGallery => _currentGallery;

  List<AssetEntity> _images;

  @override
  @computed
  get images => _images;

  AssetEntity _currentImage;

  @override
  @computed
  get currentImage => _currentImage;

  @override
  @computed
  get totalImageCount => _currentGallery.assetCount;

  bool _loading = true;

  @override
  @computed
  get loading => _loading;

  // actions:-------------------------------------------------------------------
  @override
  @action
  void initGallery() {}

  @override
  @action
  void changeGallery(AssetPathEntity gallery) {}

  @override
  @action
  void changeImage(AssetEntity image) {}

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    super.dispose();
    for (final d in disposers) {
      d();
    }
  }

  // functions:-----------------------------------------------------------------
}
