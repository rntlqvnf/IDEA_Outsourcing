import 'package:photo_manager/photo_manager.dart';

abstract class GalleryStore {
  List<AssetPathEntity> get galleries;
  AssetPathEntity get currentGallery;
  List<AssetEntity> get images;
  AssetEntity get currentImage;
  int get totalImageCount;
  bool get loading;

  void initGallery();
  void changeGallery(AssetPathEntity gallery);
  void changeImage(AssetEntity image);
}
