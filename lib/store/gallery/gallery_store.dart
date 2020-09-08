import 'package:photo_manager/photo_manager.dart';

abstract class GalleryStore {
  List<AssetPathEntity> get galleries;
  AssetPathEntity get currentGallery;
  List<AssetEntity> get images;
  AssetEntity get currentImage;
  int get totalImageCount;
  bool get loading;
  String get longestGalleryName;
  ThumbFormat get format;

  Future<void> initGallery();
  Future<void> changeGallery(AssetPathEntity gallery);
  void changeImage(AssetEntity image);
  Future<void> refreshGalleryList();
  Future<void> refreshImages();
  Future<void> loadMoreImages();
  void dispose();
}
